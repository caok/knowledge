```
def alert_due?
   !completed? &&
   current_time_is_past_due_time? &&
   !sent_yesterday? &&
   hour_is_past? &&
   minute_is_past?
end
```
上面这样写不利于一行一行的调试
```
require "active_support/core_ext"
 
class Reminder
  attr_reader :reminder_at, :completed, :last_reminded_at
 
  def initialize(completed: false, reminder_at:, last_reminded_at: nil)
    @completed = completed
    @reminder_at = reminder_at
    @last_reminded_at = last_reminded_at
  end
 
  alias completed? completed
 
  def alert_due?
    return false if     completed?
    return false unless current_time_is_past_due_time?
    return false if     sent_yesterday?
    return false unless hour_is_past?
    return false unless minute_is_past?
    true
  end
 
  def current_time_is_past_due_time?
    reminder_at <= Time.current
  end
 
  def sent_yesterday?
    last_reminded_at != nil && last_reminded_at > 23.hours.ago
  end
 
  def hour_is_past?
    reminder_at.hour <= Time.current.hour
  end
 
  def minute_is_past?
    reminder_at.min <= Time.current.min
  end
end
```

```
require "./reminder"
 
class Reminder
  # ...
  def alert_due?(audit=->(*, &block){block.call})
    return false if     audit.("task completed") { completed? }
    return false unless audit.("past due") { current_time_is_past_due_time? }
    return false if     audit.("sent yesterday") { sent_yesterday? }
    return false unless audit.("hour late enough") { hour_is_past? }
    return false unless audit.("minute late enough") { minute_is_past? }
    true
  end
  # ...
end
```

```
require "./reminder2"
r = Reminder.new(completed: false,
                 reminder_at: Time.new(2014, 1, 15, 22, 0))
 
r.alert_due?                    # => false
```
```
require "./reminder2"
r = Reminder.new(completed: false,
                 reminder_at: Time.new(2014, 1, 15, 22, 0))
 
auditor = ->(description, &test) {
  result = test.call
  puts "#{description}: #{result}"
  result
}
 
r.alert_due?(auditor)           # => false

# >> task completed: false
# >> past due: true
# >> sent yesterday: false
# >> hour late enough: false
```

```
require "./reminder2"
 
class HashAuditor
  def initialize
    @why = {}
  end
 
  def call(description)
    @why[description] = yield
  end
 
  def explain
    @why.map{|d, r| "#{d}: #{r}"}.join("; ")
  end
end
 
r = Reminder.new(completed: false,
                   reminder_at: Time.new(2014, 1, 15, 22, 0))
 
if r.alert_due?(audit = HashAuditor.new)
  # ... sound the alarm ...
else
  puts "no alert; here's why:"
  puts audit.explain
end
 
# >> no alert; here's why:
# >> task completed: false; past due: true; sent yesterday: false; hour late enough: false
```
