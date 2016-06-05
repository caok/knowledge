

# #+RESULTS:
# : ........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
# :
# : Finished in 28.46 seconds (files took 0.39819 seconds to load)
# : 1000 examples, 0 failures
# :

# This time it takes 2 /minutes/ to finish the test suite. All because
# each test had multiple database saves as a side-effect. Even though
# these tests didn't even need saved data at all in order to verify the
# behavior of the business logic.

# This is the kind of gradually accumulated test slowdown which afflicts
# a lot of Rails application test suites. Left unchecked, the almost
# inevitable result is a test suite that is rarely run, and which as a
# result may not be much of a trusted asset for the team.


require "active_record"

class MonkeyPurchase < ActiveRecord::Base
  establish_connection :adapter  => "sqlite3",
                       :database => ENV.fetch("DB") { ":memory:" }

  connection.create_table( :monkey_purchases ) do |t|
    t.integer    :quantity
    t.string     :state
    t.timestamps null: false
  end

  validates :quantity, inclusion: { in: 0..99 }

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
