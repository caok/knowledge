

# Now let's say we want to /test/ this method.{{{shot(10b)}}}

# We /could/ do it by creating a test input file, and then opening up
# two test output files and passing their =IO= objects in. But this
# would be a lot of test code. We'd have to be very careful to clean up
# the files afterwards. And working with real files is likely to slow
# our test suite down if we use that technique for more than a few
# tests.


require "rspec/autorun"

RSpec.describe "copy_with_backup" do
  it "copies input to output and backup streams" do

  end
end




# But what else can we use? Those =copy_stream= calls are expecting
# either real =IO= objects, or something which behaves exactly like
# them. Not to mention whatever we pass in as =input= must respond to
# the =#rewind= method.

# If you've watched episode #398, you probably know what's coming next.
# Ruby provides the =StringIO= class to act as a stand-in for an IO
# object, one that backed by a simple Ruby string.

#  Let's apply what we know about =StringIO= to testing the
# =#copy_with_backup= method.{{{shot(19)}}}

# We'll create three =StringIO= objects: one to stand-in for the input
# file, complete with some sample text.{{{shot(20a)}}}

# A blank one to stand-in for the output file.{{{shot(20b)}}}

# And another blank one to stand in for the backup.{{{shot(20c)}}}

# Then we'll exercise the method under test, using these fake files
# objects.{{{shot(21)}}}

# Finally, we'll verify that the string contents of the output and
# backup =StringIO= objects matches the contents of the
# input.{{{shot(22)}}}

# The result is a passing test.{{{shot(23)}}}


require "rspec/autorun"
require "./copy_with_backup"
require "stringio"

RSpec.describe "copy_with_backup" do
  it "copies input to output and backup streams" do
    input = StringIO.new("SOURCE TEXT")
    output = StringIO.new
    backup = StringIO.new
    copy_with_backup(input, output, backup)
    expect(output.string).to eq("SOURCE TEXT")
    expect(backup.string).to eq("SOURCE TEXT")
  end
end

# >> .
# >>
# >> Finished in 0.00223 seconds (files took 0.13607 seconds to load)
# >> 1 example, 0 failures
# >>
