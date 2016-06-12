
# #+TITLE: Squiggly Heredoc
# #+SETUPFILE: ../defaults.org
# #+DESCRIPTION:

# Hey, remember back in episode #250 when we talked about unindenting
# text? The context of that episode was code like this, where we want to
# include a literal string that consists of multi-line, formatted text
# in our code.

module Wonderland
  JABBERWOCKY = <<-EOF
      'Twas brillig, and the slithy toves
      Did gyre and gimble in the wabe;
      All mimsy were the borogoves,
      And the mome raths outgrabe.

    -- From "jabberwocky", by Lewis Carroll
  EOF
end
