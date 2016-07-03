
# In this program, we've repeated the same signal handler twice. It
# would be better if we could just tell =trap= to go back to using the
# /previous/ signal handler, whatever that was.

# Fortunately, there's a way to do this. =trap= always returns the /old/
# signal handler strategy when setting up a new one. We can save that in
# a variable. Then, when it comes time to reinstate the original
# handler, we can simply supply the saved value as the new handler.

trap("INT") do
  puts "Goodbye!"
  exit 0
end

loop do
  puts "Enter # of seconds: "
  seconds = gets
  old_handler = trap("INT") do
    puts "Countdown interrupted."
    break
  end
  (seconds.to_i - 1).downto(0) do |i|
    sleep 1
    puts i unless i.zero?
  end
  puts "DING!"
  trap("INT", old_handler)
end
