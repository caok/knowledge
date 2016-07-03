begin
  while (text = gets)
    puts text.upcase
  end
rescue Exception => e
  puts "Got exception:"
  p e.class
end
