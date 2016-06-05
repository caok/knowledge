

# Let's move on to a second scenario. This time, we have a series of
# tests which verify the state that the object is in after each domain
# event.{{{shot(13)}}}


require "rspec"
require "./monkey_purchase2"

RSpec.describe MonkeyPurchase do
  it "awaits signature after submission" do
    mp = MonkeyPurchase.new
    mp.submitted
    expect(mp.state).to eq("awaiting_waiver")
  end

  it "awaits approval after waiver" do
    mp = MonkeyPurchase.new
    mp.submitted
    mp.waived
    expect(mp.state).to eq("awaiting_approval")
  end

  it "ships after receiving approval" do
    mp = MonkeyPurchase.new
    mp.submitted
    mp.waived
    mp.approved
    expect(mp.state).to eq("shipping")
  end

  it "is marked complete after shipping" do
    mp = MonkeyPurchase.new
    mp.submitted
    mp.waived
    mp.approved
    mp.shipped
    expect(mp.state).to eq("complete")
  end
end
