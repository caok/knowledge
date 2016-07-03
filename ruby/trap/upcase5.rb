
# When we run this, our first Ctrl-C gets us a question, and the second
# raises an exception as usual.

# #+BEGIN_EXAMPLE
# $ ruby upcase4.rb
# ^CAre you sure?
# ^Cupcase4.rb:7:in `gets': Interrupt
#         from upcase4.rb:7:in `gets'
#         from upcase4.rb:7:in `<main>'
# #+END_EXAMPLE

# We can also tell the operating system about signals that we simply
# aren't interested in receiving. We do that using the special
# ="IGNORE"= string.

trap("INT", "IGNORE")

while (text = gets)
  puts text.upcase
end
