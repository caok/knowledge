# #+TITLE: StringIO
# #+SETUPFILE: ../defaults.org
# #+DESCRIPTION: After many passing mentions, StringIO finally gets its own episode!

# I've used instances of Ruby's =StringIO= class in several episodes
# over the years. But I realized the other day I never dedicated an
# episode to this very useful class.

# If you already understand and use =StringIO=, you can probably skip
# this episode. If you /don't/ use or know about =StringIO=, keep
# watching. Because =StringIO= is an important tool to understand.

# Let's start, though, by talking about =IO=.

# If we look at the =$stdin= and =$stdout= streams that every program
# gets, we see that they are instances of the =IO= class.{{{shot(1)}}}


$stdin                          # => #<IO:<STDIN>>
$stdout                         # => #<IO:<STDOUT>>



# If we open up a file to read, we get a =File= object back. If we ask
# the =File= class what its superclass is, we get... =IO=.{{{shot(2)}}}


open("/dev/urandom")            # => #<File:/dev/urandom>
File.superclass                 # => IO



# If we open up a pipe to a subprocess, we get back an instance of the
# =IO= class.{{{shot(3)}}}


IO.popen("cowsay") # => #<IO:fd 7>



# And if we were to open up a raw TC socket to an internet server, we'd
# use the =TCPSocket= class.{{{shot(4)}}}

# If we look at its ancestor chain, =TCPSocket= descends from
# =IPSocket=, which descends from =BasicSocket=... which descends from
# =IO=.{{{shot(5)}}}


require "socket"

TCPSocket.new "google.com", 80
# => #<TCPSocket:fd 7>

TCPSocket.ancestors
# => [TCPSocket, IPSocket, BasicSocket, IO, File::Constants, Enumerable, Object, JSON::Ext::Generator::GeneratorMethods::Object, Kernel, BasicObject]



# What we can see here is that when we're dealing with files, network
# connections, or really any kind of stream of data from or to the
# outside world, when we dig deep enough we usually find the =IO= class.
# An =IO= object is effectively a wrapper around the operating systems
# concept of a =filehandle=.

# Some programming languages break up responsibilities for IO operations
# into subsets, such as "input stream" and "output stream" classes. But
# in Ruby, input, output, or combinations of the two are all rolled into
# the =IO= class.

# Does this mean that all input and output /must/ be performed via =IO=
# objects? No it doesn't. For instance, as we learned in episode #23, we
# can use a =Tempfile= object much as we can use =File= object. We can
# write to it, close it, reopen it for reading, read from it, and so
# on.{{{shot(6)}}}

# But if we examine the =Tempfile= class, we don't find =IO= anywhere
# among its direct ancestors!{{{shot(7)}}}


require "tempfile"

temp = Tempfile.new                    # => #<Tempfile:/tmp/20160316-13069-134v9lj>
temp.write "Hello"
temp.close
temp.open
temp.read                       # => "Hello"

Tempfile.ancestors
# => [Tempfile, #<Class:0x0055cfc0f224d0>, Delegator, #<Module:0x0055cfc117fe08>, BasicObject]



# =Tempfile= is what is known as an /IO-like/ object. It behaves like an
# IO object, but isn't directly derived from that class. Because Ruby is
# all about duck-typing, we can usually use /IO-like/ objects anywhere
# that we can use a true =IO= object.

# Now that we understand a little about =IO= and IO-like objects, let's
# switch gears for a moment.

# In episode #397, we used the =mechanize= gem to do some website
# screen-scraping.{{{shot(8)}}}

# In that episode, we breezed very quickly past how we can use
# =StringIO= to help load and save cookies. Today, let's take a closer
# look.

# To begin a screen-scraping session with =mechanize=, we instantiate an
# =agent=.{{{shot(9)}}}

# Then, typically, we'd log into some website, using =mechanize=
# browser-simulation features to fill in username and password fields
# and submit the login form.{{{shot(10)}}}

# At this point, we can navigate to whatever information we need from
# the website.


require "mechanize"
agent = Mechanize.new

page = agent.get("https://secure.kobobooks.com/auth/Kobo/login")
form = page.forms[0]
form.field_with(name: "EditModel.Email").value = ENV.fetch("KOBO_EMAIL")
form.field_with(name: "EditModel.Password").value = ENV.fetch("KOBO_PASSWORD")
agent.submit(form)



# But what if this is more than a one-time thing? What if we are
# frequently retrieving information this way?

# Logging in is a time-consuming operation on many websites. We have to
# submit our credentials and then wait as the site validates them and
# then loads up our account information.

# If we have to log in every single time we need to get data from this
# site, that could easily add seconds to every single retrieval. This is
# prohibitively inefficient. And some sites crack down on clients that
# log in over and over again in a short period, since that's a potential
# sign of abuse.

# That's why, just like your desktop browser, a =mechanize= agent can
# save and load a cookies file. With the cookies saved from a previous
# session, we can pick up right where we left off, without logging in
# again.

# In order to save the cookies set by the server, we have to give our
# agent a file to write it to. Here's what that might look like.

# We open a file in =write= mode.{{{shot(11)}}}

# Then we pass the open file into the =agent.cookie_jar.dump_cookiestxt=
# method.{{{shot(12)}}}

# Now that the information is saved, the next time we instantiate an
# agent, we can just re-load the saved cookies.

# We do that by opening the cookie file in read mode...{{{shot(13)}}}

# ...then loading it into the agent with
# =agent.cookie_jar.load_cookiestxt={{{shot(14)}}}


require "mechanize"
agent = Mechanize.new

page = agent.get("https://secure.kobobooks.com/auth/Kobo/login")
form = page.forms[0]
form.field_with(name: "EditModel.Email").value = ENV.fetch("KOBO_EMAIL")
form.field_with(name: "EditModel.Password").value = ENV.fetch("KOBO_PASSWORD")
agent.submit(form)

open("cookies.txt", "w") do |file|
  agent.cookie_jar.dump_cookiestxt(file)
end

# later on...

new_agent = Mechanize.new

open("cookies.txt", "r") do |file|
  new_agent.cookie_jar.load_cookiestxt(file)
end



# As you can see, these methods expect to be passed already-open =File=
# objects. And as we now understand, what this really means is that they
# expect =IO= or IO-like= objects.

# This is great if we want to save and load our cookies to and from an
# actual file on disk. It is slightly less convenient if we want to
# store the information in some other form, like a database column.

# For the sake of example, let's say that the database we want to keep
# our cookies in is a Ruby a =PStore=.{{{shot(14b)}}}

# (We were introduced to =PStore= in episode #162)

# We'll add the =PStore= instantiation to our script.{{{shot(15)}}}


require "pstore"

database = PStore.new("data.pstore")



# Now, how can we move our cookies from a file store, into this
# database?

# Enter the =StringIO= class.{{{shot(15b)}}}

# The concept behind a =StringIO= object is simple: it simulates an
# =IO=, but all reads and writes are performed from or to an internal
# string object, instead of a file or socket.

# Before we use it to solve our testing problem, let's play around with
# it a little bit.

# We can instantiate a =StringIO= with a string of
# content.{{{shot(16)}}}

# We can read back the contents of the string as if we were reading from
# a file.{{{shot(17)}}}

# We can can rewind it to the beginning, just like we can with a real
# file.{{{shot(18)}}}

# We can even manually position the read pointer, and read individual
# characters, if we want.{{{shot(19)}}}


require "stringio"

sio = StringIO.new("Hello, world")
sio.read                        # => "Hello, world"
sio.rewind
sio.seek(7)
sio.getc                        # => "w"
sio.getc                        # => "o"



# On the flip side, we can instantiate an empty
# =StringIO=.{{{shot(20)}}}

# Then we can proceed to write to it using standard file output methods
# like =write=, the shovel operator, or even =puts=.{{{shot(21)}}}

# When we want to read back what has been written we can get access
# directly to the internal string, by using the aptly-named =#string=
# accessor.{{{shot(22)}}}

# These are just a few random examples. There are many more file-IO
# methods that StringIO faithfully simulates.


require "stringio"

sio = StringIO.new
sio.write "We don't need "
sio << "no stinkin' "
sio.puts "files!"
sio.string                      # => "We don't need no stinkin' files!\n"



# Now that we understand what =StringIO= is all about, let's apply it to
# our little cookie storing problem.

# Instead of opening a file to store the cookies, we open a =PStore=
# transaction.{{{shot(23)}}}

# Inside the transaction, we instantiate an empty =StringIO= as our
# surrogate cookie "file", to be passed to =dump_cookiestxt=
# .{{{shot(24)}}}

# Then we grab the string from inside the =StringIO=, and save it under
# a "cookies" key in our data store.{{{shot(25)}}}

# We do the same thing in reverse for reading back the cookies into a
# new agent:

# Open a transaction instead of a file.{{{shot(26)}}}

# Create a =StringIO= to stand in for a file, this time preloaded with
# the saved cookie data.{{{shot(27)}}}

# Now the cookies are being loaded form the =StringIO= instead from a
# physical file.{{{shot(28)}}}


require "stringio"
# ...
database.transaction do |data|
  file = StringIO.new
  agent.cookie_jar.dump_cookiestxt(file)
  data[:cookies] = file.string
end

# later on...

new_agent = Mechanize.new

database.transaction(true) do |data|
  file = StringIO.new(data[:cookies])
  new_agent.cookie_jar.load_cookiestxt(file)
end
