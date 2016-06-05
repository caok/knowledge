
# Lo and behold this works.{{{shot(3b)}}}


# It seems like it has validated our theory.

# In fact, though, this is a false positive. And if we continued forward
# with this incorrect understanding, it could send us down some blind
# alleys in the future. And yes, I speak from experience.

# We can start to see that our understanding of the situation is false
# if we try a different redirection. According to our theory, if we
# instead redirect standard output to =/dev/null=, we should no longer
# see an error message, since we are no longer routing the standard
# error stream to standard output.{{{shot(4)}}}

# But in fact, we see the same error message.{{{shot(5)}}}

system "pigmentize -o out.html in.html 1>/dev/null"        # => false

# !> sh: 1: pigmentize: not found
