
# And now let's run the command under =strace= again.{{{shot(14)}}}

# #+BEGIN_EXAMPLE
# $ strace -f -e execve -e signal= -qq ruby goodcmd-redir
# .rb
# execve("/home/avdi/.rubies/ruby-2.3.0/bin/ruby", ["ruby", "goodcmd-redir.rb"], [/* 79 vars */]) = 0
# syscall_318(0x7fff951e85f0, 0x10, 0, 0x560ef8264fa0, 0x560ef81f6c20, 0) = 0x10
# syscall_318(0x7fff951e8fb0, 0x10, 0, 0x560ef8232370, 0, 0x560ef6138760) = 0x10
# [pid  1735] execve("/bin/sh", ["sh", "-c", "pygmentize -o out.html in.html 2"...], [/* 79 vars */]) = 0
# [pid  1736] execve("/usr/bin/pygmentize", ["pygmentize", "-o", "out.html", "in.html"], [/* 79 vars */])
# = 0
# #+END_EXAMPLE

# This looks different! Instead two =execve= calls, we have three! The
# first is the one starting Ruby. But the second starts a shell process,
# =/bin/sh=. We can see that the arguments to the shell process include
# the command we wrote.{{{shot(15)}}}

# The third =execve= is for the =pygmentize= command itself. This is a
# subcommand of the shell process started before it.{{{shot(16)}}}

# In total, we a tree of three processes: the Ruby process, a subshell,
# and the =pygmentize= command. Whereas before we added some
# redirection, there were only two processes.

# So what's going on here?

# What has happened is that we've run into one of Ruby's special "glue
# language" features. When we give ruby an external command to execute,
# Ruby first takes a look at the command. If it looks like a simple
# command with arguments, Ruby executes it directly. But, if Ruby sees
# any special shell syntax in the command, it does something different.
# It instead starts a subshell, so that the shell program can correctly
# interpret the shell syntax. That's why, when we added a shell redirect
# to the command, we suddenly started seeing two subprocesses instead of
# just one.

# This feature can make life easier for converting system automation
# shell scripts to Ruby scripts, since it means that a lot of complex
# shell commands will "just work". But if we aren't expecting this
# behavior it can lead to confusion, bugs, and even security
# vulnerabilities.

# Ruby doesn't look only for shell redirection syntax when deciding how
# to execute a subcommand. For instance, let's say we have a script that
# executes the cowsay command.{{{shot(17)}}}

system "cowsay \"Want to make some money?\""
