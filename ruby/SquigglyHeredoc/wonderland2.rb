
# I'm very happy to say that starting with version 2.3, we no longer
# have to worry about how to unindent multiline literal strings. At long
# last, Ruby has finally added an auto-unindenting version of
# heredocs. All we have to do is change the dash in the heredoc opener,
# to a tilde instead.

module Wonderland
  #JABBERWOCKY = <<-EOF.gsub /^\s+/, ""
  JABBERWOCKY = <<~EOF
      'Twas brillig, and the slithy toves
      Did gyre and gimble in the wabe;
      All mimsy were the borogoves,
      And the mome raths outgrabe.

    -- From "jabberwocky", by Lewis Carroll
  EOF
end
