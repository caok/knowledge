while (print "> "; input = gets) do
  input.chomp!
  puts "Input was: #{input.inspect}"
  case input
  when "time" then puts Time.now
  when "quit", "exit" then break
  else puts "I don't know that command"
  end
end
