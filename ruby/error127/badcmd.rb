
# #+TITLE: Magic Subshell
# #+SETUPFILE: ../defaults.org
# #+DESCRIPTION: Today we dive into some surprising behavior when executing shell commands from Ruby.

# Long before Ruby was a preeminent web application programming
# language, Ruby was scripting language for "gluing" other programs
# together in the tradition of Perl. As a "glue language", Ruby goes out
# of its way to make it easy to execute subprograms and little shell
# snippets. In fact, sometimes it tries so hard to make this kind of
# programming painless that things can get a little bit magical,
# surprising, and even dangerous---as we'll see today.

# Back in episode #385, we discovered an annoyance about executing other
# programs from within Ruby. If we use the =system= method to execute
# the program, but we misspell the name, we don't get any kind of error
# message. Instead, we get a =nil= result.{{{shot(1)}}}

# If we know where to look, we can find out that the exit status
# was 127.{{{shot(2)}}}

system "pigmentize -o out.html in.html" # => nil
$?.exitstatus                   # => 127
