

# Here's an RSpec test scenario for the =MonkeyPurchase=
# class.{{{shot(8)}}}

# In order to simulate a large, established test suite without actually
# writing one, I've enclosed one example inside a loop that repeats a
# thousand time.{{{shot(9)}}}

# Like many real-world unit tests, there's some common setup that
# happens in all of the examples. In this case, it consists of making a
# new =MonkeyPurchase= and then stepping it through several events.


require "./monkey_purchase"
RSpec.describe MonkeyPurchase do
  1000.times do |n|
    it "does thing ##{n}" do
      mp = MonkeyPurchase.new
      mp.submitted
      mp.waived
      mp.approved
      mp.shipped
    end
  end
end
