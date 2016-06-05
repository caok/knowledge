# #+TITLE: Self Save Part 1
# #+SETUPFILE: ../defaults.org
# #+DESCRIPTION: What's so wrong with an object saving itself? Today we set out to answer that question.

# Back in episode #331, as we were discussing the concept of "process
# objects", I showed this code:{{{shot(1)}}}


post "/purchase_monkeys" do
  card_info = params[:card_info]
  quantity  = params[:quantity].to_i
  user      = current_user
  purchase = MonkeyPurchase.new(
    user:      user,
    card_info: card_info,
    quantity:  quantity)
  purchase.submitted
  purchase.save!
  "Your purchase is pending approval"
end
