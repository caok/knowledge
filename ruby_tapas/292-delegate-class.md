```
class AuditLog
  def record(number, action, amount, balance)
    printf(
      "%<time>s #%<number>s %<action>s %<amount>.2f (%<balance>.2f)\n",
      time:    Time.now,
      number:  number,
      action:  action,
      amount:  amount / 100,
      balance: balance / 100)
  end
end

class BankAccount
  attr_reader :number, :balance_cents
 
  def initialize(number)
    @number        = number
    @balance_cents = 0
  end
 
  def deposit(amount)
    @balance_cents += amount
  end
 
  def withdraw(amount)
    @balance_cents -= amount
  end
 
  def inspect
    "#<%s %s ($%0.2f)>" %
      [self.class, @number, @balance_cents / 100.0]
  end
  alias_method :to_s, :inspect
end
```

### SimpleDelegator
```
require 'delegate'
class AuditedAccount < SimpleDelegator
  def initialize(account, audit_log)
    super(account)
    @audit_log = audit_log
  end

  def deposit(amount)
    super
    @audit_log.record(number, :deposit, amount, balance_cents)
  end

  def withdraw(amount)
    super
    @audit_log.record(number, :withdraw, amount, balance_cents)
  end
end
```

```
account = BankAccount.new(123456)
log = AuditLog.new
 
aa = AuditedAccount.new(account, log)
 
account.number                  # => 123456
aa.number                       # => 123456
 
aa == account                   # => true
```

### DelegateClass
```
require "delegate"
require "./bank_account"
 
class AuditedAccount2 < DelegateClass(BankAccount)
  def initialize(account, audit_log)
    super(account)
    @audit_log = audit_log
  end
 
  def deposit(amount)
    super
    @audit_log.record(number, :deposit, amount, balance_cents)
  end
 
  def withdraw(amount)
    super
    @audit_log.record(number, :withdraw, amount, balance_cents)
  end
end
```

```
account = BankAccount.new(123456)
log = AuditLog.new
 
aa1 = AuditedAccount.new(account, log)
aa2 = AuditedAccount2.new(account, log)
 
aa1.number                      # => 123456
aa2.number                      # => 123456
 
AuditedAccount.instance_methods.include?(:number)
# => false
 
AuditedAccount2.instance_methods.include?(:number)
# => true
```
不同点
1.the DelegateClass has to have a dependency on the class it is intended to wrap, so we can’t develop it or test it in isolation.
DelegateClass 必须依赖于他想要包装的class, 所以我们不能孤立的去开发或者测试它

2.性能上DelegateClass 要比SimpleDelegator快一些，但差别不大

```
# >>                            user     system      total        real
# >> SimpleDelegator        1.960000   0.030000   1.990000 (  2.028429)
# >> DelegateClass          1.720000   0.040000   1.760000 (  1.811097)
```

If we know exactly the class we plan on wrapping, we might as well use DelegateClass and reap the benefits of slightly better performance and introspection.
如果我们确切的知道我们计划将要包装的类, 我们不如就用DelegateClass，以获得略好的性能和内省.
But if we to minimize dependencies, or we think that we will be decorating a range of similar classes rather than just a single type of object, SimpleDelegator is an easy choice.
但是我们若想要最小化依赖，或者我们想要装饰一系列相似的类，而不只是一个单一类型的对象，那么SimpleDelegator会是一个简单的选择

* http://www.kuqin.com/rubycndocument/man/addlib/delegate.html
