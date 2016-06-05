
# Let's go to the command line and run Rake.{{{shot(2)}}}

# We're a bit disappointed to see an error.{{{shot(3)}}}

# #+BEGIN_EXAMPLE

# $ rake source.html
# pigmentize -o source.html source.rb
# rake aborted!
# Command failed with status (127): [pigmentize -o source.html source.rb...]
# /home/avdi/Dropbox/rubytapas/385-error-127/Rakefile:3:in `block in <top (require
# d)>'
# Tasks: TOP => source.html
# (See full trace by running task with --trace)

# #+END_EXAMPLE

# Hmmm... "command failed with status (127)". That doesn't tell us much.
# Let's try running Rake with verbose mode and trace mode on. Surely
# that will give us the information we need, and then some.{{{shot(4)}}}

# #+BEGIN_EXAMPLE

# $ rake --verbose --trace source.html
# Invoke source.html (first_time)
# Invoke source.rb (first_time, not_needed)
# Execute source.html
# pigmentize -o source.html source.rb
# rake aborted!
# Command failed with status (127): [pigmentize -o source.html source.rb...]
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/file_utils.rb:66:in `block in create_shell_runner'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/file_utils.rb:57:in `call'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/file_utils.rb:57:in `sh'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/file_utils_ext.rb:37:in `sh'
# /home/avdi/Dropbox/rubytapas/385-error-127/Rakefile:3:in `block in <top (required)>'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/task.rb:240:in `call'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/task.rb:240:in `block in execute'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/task.rb:235:in `each'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/task.rb:235:in `execute'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/task.rb:179:in `block in invoke_with_call_chain'
# /home/avdi/.rubies/ruby-2.1.3/lib/ruby/2.1.0/monitor.rb:211:in `mon_synchronize'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/task.rb:172:in `invoke_with_call_chain'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/task.rb:165:in `invoke'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:150:in `invoke_task'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:106:in `block (2 levels) in top_level'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:106:in `each'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:106:in `block in top_level'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:115:in `run_with_threads'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:100:in `top_level'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:78:in `block in run'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:176:in `standard_exception_handling'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/lib/rake/application.rb:75:in `run'
# /home/avdi/.gem/ruby/2.1.3/gems/rake-10.4.2/bin/rake:33:in `<top (required)>'
# /home/avdi/.gem/ruby/2.1.3/bin/rake:23:in `load'
# /home/avdi/.gem/ruby/2.1.3/bin/rake:23:in `<main>'
# Tasks: TOP => source.html

# #+END_EXAMPLE

# Well we certainly got a lot more information that time. But when we
# look carefully, we're surprised to find that there's no added
# information about the error itself.{{{shot(5)}}}

# OK, let's eliminate as many variables as we can. Instead of running
# the command inside a Rake task, let's just use Ruby's =system= method
# to run it.{{{shot(6)}}}

system "pigmentize -o source.html source.rb"
# => nil

# Wow. That didn't tell us much either.

# =system= is supposed to return =true= if the command succeeded, and
# =false= if it fails. We didn't get either of those. We got =nil=. And
# whatever went wrong, it apparently failed before it could output any
# error messages.

# Fortunately, there's a way to ask Ruby what happened to the last
# subprocess it tried to run.

# We can use the =$?= variable to get at a =Process::Status
# object.{{{shot(7)}}}

# We can ask this object what its exit status was.{{{shot(8)}}}

system "pigmentize -o source.html source.rb"
$? # => #<Process::Status: pid 5386 exit 127>
$?.exitstatus                   # => 127
