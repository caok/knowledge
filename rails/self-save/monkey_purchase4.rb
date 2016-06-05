

# Moving on to another scenario...

# Here's yet another version of the =MonkeyPurchase= class.{{{shot(27)}}}

# In this one, we've learned from mistakes of the past. There's an
# =after_save= hook here as well, but instead of putting work directly
# inside the hook, the hook just adds a job to a background job-queueing
# class.{{{shot(28)}}}


require "active_record"
require "net/http"

class JobOTron
  def self.enqueue_job(*args, &job)
    (@jobs ||= []) << [job, *args]
  end

  def self.run_jobs
    (@jobs ||= []).each do |job|
      job.first.call(*job.drop(1))
    end
  end
end

class MonkeyPurchase < ActiveRecord::Base
  establish_connection :adapter  => "sqlite3",
                       :database => ENV.fetch("DB") { ":memory:" }

  connection.create_table( :monkey_purchases ) do |t|
    t.integer    :quantity
    t.string     :customer
    t.string     :postal_code
    t.string     :state
    t.timestamps null: false
  end

  after_save do
    if state == "awaiting_waiver"
      JobOTron.enqueue_job(id) do |id|
        purchase = MonkeyPurchase.find(id)
        purchase.email_waiver_to_customer
      end
    end
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

  def email_waiver_to_customer
    puts "Emailing monkey waiver to #{customer}"
  end
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
