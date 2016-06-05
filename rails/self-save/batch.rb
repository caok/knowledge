

# #+RESULTS:
# #+begin_example
# FFFF

# Failures:

#   1) MonkeyPurchase awaits signature after submission
#      Failure/Error: mp.submitted

#      ActiveRecord::RecordInvalid:
#        Validation failed: Quantity is not included in the list
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/validations.rb:79:in `raise_record_invalid'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/validations.rb:43:in `save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/attribute_methods/dirty.rb:29:in `save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:291:in `block in save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:351:in `block in with_transaction_returning_status'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `block in transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/transaction.rb:184:in `within_new_transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:220:in `transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:348:in `with_transaction_returning_status'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:291:in `save!'
#      # ./monkey_purchase2.rb:27:in `save!'
#      # ./monkey_purchase2.rb:35:in `submitted'
#      # ./validations_spec.rb:7:in `block (2 levels) in <top (required)>'

#   2) MonkeyPurchase awaits approval after waiver
#      Failure/Error: mp.submitted

#      ActiveRecord::RecordInvalid:
#        Validation failed: Quantity is not included in the list
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/validations.rb:79:in `raise_record_invalid'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/validations.rb:43:in `save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/attribute_methods/dirty.rb:29:in `save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:291:in `block in save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:351:in `block in with_transaction_returning_status'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `block in transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/transaction.rb:184:in `within_new_transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:220:in `transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:348:in `with_transaction_returning_status'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:291:in `save!'
#      # ./monkey_purchase2.rb:27:in `save!'
#      # ./monkey_purchase2.rb:35:in `submitted'
#      # ./validations_spec.rb:13:in `block (2 levels) in <top (required)>'

#   3) MonkeyPurchase ships after receiving approval
#      Failure/Error: mp.submitted

#      ActiveRecord::RecordInvalid:
#        Validation failed: Quantity is not included in the list
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/validations.rb:79:in `raise_record_invalid'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/validations.rb:43:in `save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/attribute_methods/dirty.rb:29:in `save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:291:in `block in save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:351:in `block in with_transaction_returning_status'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `block in transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/transaction.rb:184:in `within_new_transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:220:in `transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:348:in `with_transaction_returning_status'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:291:in `save!'
#      # ./monkey_purchase2.rb:27:in `save!'
#      # ./monkey_purchase2.rb:35:in `submitted'
#      # ./validations_spec.rb:20:in `block (2 levels) in <top (required)>'

#   4) MonkeyPurchase is marked complete after shipping
#      Failure/Error: mp.submitted

#      ActiveRecord::RecordInvalid:
#        Validation failed: Quantity is not included in the list
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/validations.rb:79:in `raise_record_invalid'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activernecord-4.2.6/lib/active_record/validations.rb:43:in `save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/attribute_methods/dirty.rb:29:in `save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:291:in `block in save!'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:351:in `block in with_transaction_returning_status'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `block in transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/transaction.rb:184:in `within_new_transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:220:in `transaction'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:348:in `with_transaction_returning_status'
#      # /home/avdi/.gem/ruby/2.3.0/gems/activerecord-4.2.6/lib/active_record/transactions.rb:291:in `save!'
#      # ./monkey_purchase2.rb:27:in `save!'
#      # ./monkey_purchase2.rb:35:in `submitted'
#      # ./validations_spec.rb:28:in `block (2 levels) in <top (required)>'

# Finished in 0.01631 seconds (files took 0.34544 seconds to load)
# 4 examples, 4 failures

# Failed examples:

# rspec ./validations_spec.rb:5 # MonkeyPurchase awaits signature after submission
# rspec ./validations_spec.rb:11 # MonkeyPurchase awaits approval after waiver
# rspec ./validations_spec.rb:18 # MonkeyPurchase ships after receiving approval
# rspec ./validations_spec.rb:26 # MonkeyPurchase is marked complete after shipping

# #+end_example

# The issue here is that because the object implicitly saves itself, we
# are now required to make sure all of its attributes are valid when
# working with it---even if some of those attributes are completely
# irrelevant to the task at hand!

# At this point, this is where a lot of Rails developers turn to using a
# test factory approach, such as the =FactoryGirl= library, to automate
# building valid example objects. But in my opinion this is really just
# a cosmetic band-aid for a deeper design issue. In general, if a single
# unrelated change breaks numerous tests, it's a good idea to ask if
# perhaps this is a sign of tangled responsibilities.

# Next scenario! Our monkey delivery service has been doing brisk sales,
# and we're expanding our business. Lately we've begun setting up booths
# at traveling circuses, collecting orders on paper, and then entering
# them into the system in batches once we reach an internet connection.

# The batch-entry code looks like this:{{{shot(17)}}}

# It makes use of the fact that =ActiveRecord= makes it possible to
# batch-create new records by passing a list of hashes to the =create=
# class method.

# We're also making use of the fact that we can operate on records
# inside the block given to a =.create= call. Here, we're letting each
# record know that it should consider itself submitted, and that the
# customer has already signed a waiver of liability.{{{shot(18)}}}

# Let's do a little benchmarking here. First, we'll submit a batch of
# 1000 orders with self-saving manually disabled.{{{shot(19)}}}

# Then we'll do the same thing, but with the objects permitted to save
# themselves whenever they want.{{{shot(20)}}}

# When we run this benchmark, the results are clear: the version where
# self-saving was enabled was considerably slower.{{{shot(21)}}}

# Each time we sent an object a message to tell it that a lifecycle
# event had occurred, it went ahead and saved itself. None of these
# extra saves were necessary. The newly created objects would have wound
# up persisted to the database either way.

# And remember, just as before we're using an in-memory SQLite database
# to benchmark this code. It's fairly safe to assume that a file-based
# database, or one on the other end of a TCP connection, would be a lot
# slower still.


require "./monkey_purchase"
require "faker"

def batch_submit_orders(orders)
  MonkeyPurchase.create(orders) do |mp|
    mp.submitted
    mp.waived
  end
end


require "benchmark"

orders = 1000.times.map {
  { customer: Faker::Name.name, quantity: rand(1..99) }
}

Benchmark.bm(12) do |x|
  x.report("no self-save") do
    batch_submit_orders(orders)
  end
  x.report("self-save") do
    ENV["SELFSAVE"] = "YES"
    batch_submit_orders(orders)
  end
end

# >>                    user     system      total        real
# >> no self-save   0.610000   0.010000   0.620000 (  0.618479)
# >> self-save      1.200000   0.010000   1.210000 (  1.211359)
