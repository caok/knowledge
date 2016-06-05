
# This time, the command doesn't give us the output we
# expect.{{{shot(20)}}}

# #+BEGIN_EXAMPLE
# $ ruby cowsay-dollars.rb
#  _________________________
# < Want to make some 60810 >
#  -------------------------
#         \   ^__^
#          \  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||
# #+END_EXAMPLE

# Why? Because Ruby saw something in the command that it interpreted as
# shell syntax. Specifically, "dollar dollar" is a shell special
# variable referring to the current process ID. And "dollar question" is
# the exit value of the last executed command, if any. By "helpfully"
# running this command inside a shell process, Ruby wound up breaking
# our script.

# In this case, the outcome is merely wrong and surprising. But we could
# easily imagine a scenario where this "feature" introduced serious
# security vulnerabilities. For instance, what if the cow's message was
# specified by an interpolated variable, and the variable's value came
# from an untrusted user?{{{shot(21)}}}

message = "This doesn'\t seem safe"
system "cowsay \"#{message}\""
