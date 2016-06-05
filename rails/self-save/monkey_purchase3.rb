

# But then someone goes and adds an after-save hook.{{{shot(23)}}}

# The hook checks to see if the object is awaiting approval. If so, it
# kicks off a request to the =ZooPS= shipping service to see if exotic
# animal delivery is approved to the customer's postal
# code.{{{shot(24)}}}


require "active_record"
require "net/http"

class ZooPS
  def self.can_ship_to?(postal_code)
    Net::HTTP.get_response("localhost", "/shipping_approval?code=#{postal_code}")
    true
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
    if state == "awaiting_approval"
      if ZooPS.can_ship_to?(postal_code)
        self.state = "approved"
      else
        self.state = "denied"
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
end
