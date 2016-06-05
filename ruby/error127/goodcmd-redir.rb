
# =strace= is a linux utility that can show us the system calls a
# program makes as it is executing. {{{shot(7)}}}

# There are similar tools for other operating systems, like =dtrace= on
# Max OS X.

# We'll tell =strace= that we want to trace down through any
# subprocesses, and that we are only interested in seeing information
# about calls to the =execve= function. That's a function which starts
# up a new subprocess.{{{shot(8)}}}

# We also specify some other options to limit the amount of extra output
# we get from =strace=.{{{shot(8b)}}}

# At the end of the command, we put the =ruby= command we want to
# trace.{{{shot(9)}}}

# When we execute this, we see a couple of lines of =strace= logging
# output.{{{shot(10)}}}

# First, we see a call to =execve= where the Ruby process is
# started.{{{shot(11)}}}

# Next, we see an =execve= that executes the =pygmentize=
# command.{{{shot(12)}}}

# #+BEGIN_EXAMPLE
# $ strace -f -e execve -e signal= -qq ruby goodcmd.rb
# execve("/home/avdi/.rubies/ruby-2.3.0/bin/ruby", ["ruby", "goodcmd.rb"], [/* 79 vars */]) = 0
# syscall_318(0x7ffd73c0e4c0, 0x10, 0, 0x55ba5d0fdf50, 0x55ba5d08fc20, 0) = 0x10
# syscall_318(0x7ffd73c0ee80, 0x10, 0, 0x55ba5d0ce348, 0, 0x55ba5c698760) = 0x10
# [pid 16538] execve("/usr/bin/pygmentize", ["pygmentize", "-o", "out.html", "in.html"], [/* 79 vars */])
# = 0
# #+END_EXAMPLE

# So far so good. Now let's change the script to include some
# redirection.{{{shot(13)}}}

system "pygmentize -o out.html in.html 2>&1"
