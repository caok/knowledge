
# When we execute this, it does what we expect, assuming we know about
# the the cowsay command.{{{shot(18)}}}

# #+BEGIN_EXAMPLE
# $ ruby cowsay.rb
#  __________________________
# < Want to make some money? >
#  --------------------------
#         \   ^__^
#          \  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||
# #+END_EXAMPLE

# Now let's make a small change to the script.{{{shot(19)}}}

system "cowsay \"Want to make some $$$?\""
