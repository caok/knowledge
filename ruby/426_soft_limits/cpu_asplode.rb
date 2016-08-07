require "prime"

trap("XCPU") do
  puts "Received SIGXCPU, shutting down...\n"
  #exit
end

Prime.each do |n|
  #puts n
end
