
# The user might specify a value that escapes the string and executes
# arbitrary commands!{{{shot(22)}}}

message = "Bye bye!\"; rm cowsay-malicious.rb; echo \""
system "cowsay \"#{message}\""
