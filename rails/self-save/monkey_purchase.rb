

# As you might recall, we were writing code for an online store called
# Instant Monkeys Online. Here, a =MonkeyPurchase= object is constructed
# to represent the process of purchasing monkeys.{{{shot(2)}}}

# Then, the object is informed that the purchase has officially been
# submitted, triggering some domain logic.{{{shot(3)}}}

# Finally, we save the new state of the =MonkeyPurchase=.{{{shot(4)}}}

# I received one question over and over again about this code: why did I
# have the controller action save the domain object? Why didn't I have
# it save itself, as part of the =submitted= method?

# As it happens, there /is/ a reason for this choice. Having an object
# save itself in response to business domain activities can lead to a
# variety of undesirable and difficult-to-diagnose problems down the
# road.

# In order to demonstrate the issues with domain model self-saving, I
# searched my own memory as well as gathering the experiences of a
# number of other developers. From that research, I've boiled down seven
# scenarios that illustrate the kind of bugs that can crop up as a
# result of this practice.

# A few caveats before we begin:

# First, we have a lot of scenarios to get through, and despite my best
# efforts to simplify, they are all fairly involved. As a result, this
# is going to be the start of a miniseries, so you don't have to sit
# through a twenty-minute episode.

# I felt that it was important to show a wide array of examples, in
# order to give you the clearest possible picture of the variety of ways
# self-saving can introduce problems. By the end of this miniseries,
# hopefully you'll be able to see how it's not just a matter of one or
# two "gotchas" to avoid. Rather, self-saving is a sign of a fundamental
# flaw in object design.

# Second: while some of the examples I'm going to show you may seem
# contrived, they are /all/ based on actual events. They are either
# derived from my own experiences, or from the experiences of other
# developers. The following examples are intended to represent the world
# of code as it really exists, not as it theoretically "ought" to be.

# Before we get into the scenarios proper, let's quickly talk about an
# objection to self-saving that doesn't require any special demo code.
# It's this: /if/ we let the object save itself, that implicitly means
# we are tying this business model to the persistance library. In all
# the following examples, that library will be ActiveRecord. So right
# from the outset, by making this choice we're forcing ourselves to load
# ActiveRecord and set up a database just to be able to run our unit
# tests.

# A lot has already been written about the value of code that can be
# isolated from database and framework dependencies, especially in the
# context of testing. I'm not going to belabor that point now. I just
# wanted to point out that just by having these objects save themselves,
# we're choosing to forgo the advantages of minimal dependencies and
# ultra-fast tests.

# Now let's move on and talk about some of the less obvious objections.
# We'll start with another testing-related scenario.

# Here's a new version of the =MonkeyPurchase= process object. It
# derives from =ActiveRecord::Base=.{{{shot(5)}}}

# I've overridden the =save!= method to make it possible to enable or
# disable saves with an environment switch, without changing the
# code.{{{shot(6)}}} This is /only/ there for the purpose of making
# it easier to quickly switch between self-saving and non-self-saving
# versions in these examples. It's not something you would find in
# real-world code.

# The class contains methods representing a series of events that may
# happen over the lifetime of a monkey purchase process. For the sake of
# example, I haven't included any domain logic in any of these event
# handlers. Instead, each one just updates the object's state, and then
# saves itself.{{{shot(7)}}}


require "active_record"

class MonkeyPurchase < ActiveRecord::Base
  establish_connection :adapter  => "sqlite3",
                       :database => ENV.fetch("DB") { ":memory:" }

  connection.create_table( :monkey_purchases ) do |t|
    t.integer    :quantity
    t.string     :customer
    t.string     :state
    t.timestamps null: false
  end

  def save!
    if ENV["SELFSAVE"] == "YES"
      super
    else
      # NOOP
    end
  end

  def submitted
    self.state = "awaiting_waiver"
    save!
  end

  def waived
    self.state = "awaiting_approval"
    save!
  end

  def approved
    self.state = "shipping"
    save!
  end

  def shipped
    self.state = "complete"
    save!
  end
end
