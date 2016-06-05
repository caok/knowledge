

# So what happened? Well, remember how the operations in the
# =submit_purchase= method were all enclosed in a transaction?
# {{{shot(38)}}}

# Well, the =MonkeyPurchase#submitted= method implicitly saved the
# object. And a job was en queued to do some deferred work---complete
# with the row ID of the =MonkeyPurchase= record it should work on.

# But it was saved in the context of that database transaction.

# Later, the exception that was raised caused the transaction to
# be aborted. The save was rolled back. But no one told the delayed job
# about this. And it blew up.

# A failed job isn't the end of the world. But sooner or later we're
# going to have to trace down the source of the job failures. Good luck
# debugging that convoluted chain of events!

# Problems aren't only caused by introducing transactions. Removing a
# transaction can be just as problematic.

# Here's a new version of =MonkeyPurchase=.{{{shot(39)}}}

# It has a new association: it can own a single =Waiver=
# object.{{{shot(40)}}}

# This is an electronically signed waiver indemnifying the company from
# any and all damage and/or poo-flinging incidents caused by the
# delivered monkeys.

# After the order is marked as submitted, the =MonkeyPurchase= object
# saves itself, just as in all the preceding examples. But this time, it
# also creates the associated =waiver= before returning.

# Or, well, it /tries/ to, anyway. Sadly


require "active_record"

class ActiveRecord::Base
  establish_connection :adapter  => "sqlite3",
                       :database => ENV.fetch("DB") { ":memory:" }

  connection.create_table( :monkey_purchases ) do |t|
    t.integer    :quantity
    t.string     :customer
    t.string     :postal_code
    t.string     :state
    t.timestamps null: false
  end

  connection.create_table( :waivers ) do |t|
    t.integer :monkey_purchase_id
    t.boolean :signed
  end
end

class MonkeyPurchase < ActiveRecord::Base

  has_one :waiver

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
    create_waiver
  end

  def waived
    self.state = "awaiting_approval"
    save!
  end
end

class Waiver < ActiveRecord::Base
  before_create do
    raise "Behold, a bug!"
  end

  belongs_to :monkey_purchase
end


--------------------------------------------------------------
ENV["SELFSAVE"] = "YES"

def submit_purchase
  MonkeyPurchase.transaction do
    mp = MonkeyPurchase.new(customer: "Man in the Yellow Hat")
    mp.submitted

    # ...

    raise "Whoopsie"
  end
rescue
  puts "Something went wrong. Try again later!"
end
