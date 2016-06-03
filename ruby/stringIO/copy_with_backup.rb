# #+TITLE: StringIO Test Fake
# #+SETUPFILE: ../defaults.org
# #+DESCRIPTION: Today we learn about how the StringIO class can help us test methods that work with files.

# In episode #397, we got our first /proper/ introduction to the
# =StringIO= standard library. But we only saw one example usage for it.
# Today I want to demonstrate another area where I find this library to
# be useful: in tests.

# Let's say we have a method called =copy_with_backup=. Its job is to
# copy an input file to both an output file and a backup
# file.{{{shot(8)}}}

# Some other method is responsible for finding and opening the
# appropriate files. This method is only responsible for performing the
# copies. In order to do the copying efficiently, it uses
# =IO.copy_stream=, which we first encountered in episode #74.{{{shot(9)}}}

# Note that it also uses the =IO= method =#rewind=, in order to reset
# the input back to the beginning before the second copy.{{{shot(10)}}}


def copy_with_backup(input, output, backup)
  IO.copy_stream(input, output)
  input.rewind
  IO.copy_stream(input, backup)
end
