loop do
  print "> "
  input = gets
  input.chomp! unless input.nil?
  puts "Input was: #{input.inspect}"
  break if input.nil?
end
