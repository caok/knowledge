
# #+TITLE: Crystal
# #+SETUPFILE: ../defaults.org
# #+DESCRIPTION: Today we meet a young programming language which looks suspiciously similar to Ruby.

# Ruby is a dynamic language, which gives it a great deal of flexibility
# and power. But this dynamism means that Ruby code tends to run more
# slowly than code in statically-compiled languages. It also means that
# many errors in coding will only be detected when the code is actually
# executed. This is one reason the Ruby community emphasizes having lots
# of automated tests.

# Here's a Ruby program which takes a word on the command line, and
# looks for anagrams of that word using the system dictionary. The
# details of how this code works aren't important. What's important to
# understand is that it first builds a lookup table where words have
# been sorted out by the letters they contain. Then it looks up the
# given word in that table.

table = Hash.new { |h,k|
  h[k] = []
}
IO.foreach("/usr/share/dict/words") do |line|
  word = line.chomp
  key  = word.downcase.chars.sort.join
  table[key] << word
end

word     = ARGV[0].downcase
anagrams = table[word.chars.sort.join]
anagrams.map!(&:downcase)
anagrams.delete(word)
if anagrams.any?
  puts "Anagrams for '#{word}': #{anagrams.join(", ")}"
else
  puts "Sorry, no anagrams for '#{word}'"
end
