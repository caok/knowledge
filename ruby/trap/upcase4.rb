trap("INT") do
  puts "Are you sure?"
  trap("INT", "DEFAULT")
end

while (text = gets)
  puts text.upcase
end
#When we run this, our first Ctrl-C gets us a question, and the second raises an exception as usual.
