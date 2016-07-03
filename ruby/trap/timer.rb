
# This might be appropriate in some cases, but in general it's a feature
# to be used with care.

# We've seen a case so far where we reinstate the Ruby default handling
# of a signal after temporarily customizing it. But what if the signal
# in question was already customized, and we return it to the "default"
# handler? In that case, we've effectively thrown away the original
# customization. Which may not be what we want.

# Here's an example. Consider a simple countdown timer application. It
# prompts us for a number of seconds, then counts down. At the end of
# the countdown it prints "DING!", and then prompts us for another
# number of seconds.

# #+BEGIN_EXAMPLE
# $ ruby timer.rb
# Enter # of seconds:
# 3
# 2
# 1
# DING!
# Enter # of seconds:
# #+END_EXAMPLE

# If we press Ctrl-C while we are at the prompt, the program exits
# cleanly with a message.

# #+BEGIN_EXAMPLE
# Enter # of seconds:
# ^CGoodbye!
# #+END_EXAMPLE

# But if we hit Ctrl-C /during/ a countdown, it doesn't quit the
# program. Instead, it interrupts the countdown and returns us to the
# prompt.

# #+BEGIN_EXAMPLE
# $ ruby timer.rb
# Enter # of seconds:
# 5
# 4
# 3
# ^CCountdown interrupted.
# DING!
# Enter # of seconds:
# #+END_EXAMPLE

# Let's see how this is accomplished. In the code for our timer
# application, we start off by trapping SIGINT and setting up a clean
# exit handler.

# Then, we start a prompt loop. We output a prompt, and accept a number
# of seconds.

# Then we /override/ the current handler for SIGINT with another trap.
# This time, we supply a handler that will break out of the current
# loop.

# Next we implement our countdown timer. Finally, after it has expired,
# we reinstate the old SIGINT trap with the goodbye message and exit.

trap("INT") do
  puts "Goodbye!"
  exit 0
end

loop do
  puts "Enter # of seconds: "
  seconds = gets
  trap("INT") do
    puts "Countdown interrupted."
    break
  end
  (seconds.to_i - 1).downto(0) do |i|
    sleep 1
    puts i unless i.zero?
  end
  puts "DING!"
  trap("INT") do
    puts "Goodbye!"
    exit 0
  end
end
