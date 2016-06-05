
# When we execute this, the program gives us a cheeky message and then
# deletes itself.{{{shot(22b)}}}

# #+BEGIN_EXAMPLE
# $ ruby cowsay-malicious.rb
#  __________
# < Bye bye! >
#  ----------
#         \   ^__^
#          \  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||
# $ ls cowsay-malicious.rb
# ls: cannot access cowsay-malicious.rb: No such file or directory
# #+END_EXAMPLE

# There is one way to /ensure/ that nothing like this ever happens.
# Let's look at how we can make this program safe.

# Instead of passing a single string to =system=, we pass multiple
# arguments. The first is the command itself, and the rest are treated
# as flags or arguments to the command.{{{shot(23)}}}

message = "Bye bye!\"; rm cowsay-safe.rb; echo \""
system("cowsay", message)
