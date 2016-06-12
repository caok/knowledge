
# We're using a heredoc, and we've indented the text to the right
# because we want it to be consistent with our overall code indenting
# style. The problem is, Ruby includes that indenting space in the
# resulting string object. The consequence is that, when we dump the
# string, the whole passage is still indented by four spaces.

require "./wonderland"
puts Wonderland::JABBERWOCKY

# >>       'Twas brillig, and the slithy toves
# >>       Did gyre and gimble in the wabe;
# >>       All mimsy were the borogoves,
# >>       And the mome raths outgrabe.
# >>
# >>     -- From "jabberwocky", by Lewis Carroll

# When we dump it out, Ruby strips off indentation until the
# least-indented line in the text is touching the lefthand margin. As
# you can see in this example, the least indented line was the
# attribution line at the end. The whole poem has been unindented to the
# point where that line is up against the margin, but no further. This
# has left the poem's verse correctly indented relative to the
# attribution.

require "./wonderland2"
puts Wonderland::JABBERWOCKY

# >>   'Twas brillig, and the slithy toves
# >>   Did gyre and gimble in the wabe;
# >>   All mimsy were the borogoves,
# >>   And the mome raths outgrabe.
# >>
# >> -- From "jabberwocky", by Lewis Carroll
