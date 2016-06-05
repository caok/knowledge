
# So what is really going on here? To get a better understanding of
# what's actually happening, we can turn to the =strace=
# utility.

# We're going to first save a version of the program that has the
# correct spelling and does /no/ redirection.{{{shot(6)}}}

system "pygmentize -o out.html in.html"
