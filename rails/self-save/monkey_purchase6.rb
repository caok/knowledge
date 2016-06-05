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
    build_waiver
    self.state = "awaiting_waiver"
    save!
  end

  def waived
    self.state = "awaiting_approval"
    save!
  end
end

class Waiver < ActiveRecord::Base
  belongs_to :monkey_purchase
end
