```
def process_payment(payment)
  save_payment_record(payment)
  if payment.card_payment?
    process_payment_with_card_processor(payment)
  elsif payment.bank_payment?
    process_payment_with_bank_process(payment)
  else
    # no need to process anything for cash, money order, etc.
  end
 
  if payment.approved?
    send_receipt(payment)
    do_accounting(payment)
    do_reporting(payment)
    do_internal_notifications(payment)
  end
end
```

每种付款方式都有属于自己的付款处理方法
```
class CardPayment
  def process
    save_record
    process_with_card_processor
    send_receipt
    if approved?
      do_accounting
      do_reporting
      do_internal_notifications
    end
  end
end
 
class BankPayment
  def process
    save_record
    process_with_bank_processor
    send_receipt
    if approved?
      do_accounting
      do_reporting
      do_internal_notifications
    end
  end
end
 
class CashPayment
  def process
    save_record
    send_receipt
    if approved?
      do_accounting
      do_reporting
      do_internal_notifications
    end
  end
end
```
重构，将重复部分抽离到payment中
```
class Payment
  def process
    save_record
    do_process
    if approved?
      send_receipt
      do_accounting
      do_reporting
      do_internal_notifications
    end
  end
end
 
class CardPayment < Payment
  def do_process
    process_with_card_processor
  end
end
 
class BankPayment
  def do_process
    process_with_bank_processor
  end
end
 
class CashPayment
  def do_process
    # NOOP
  end
end
```

```
class Payment
  def process
    save_record
    do_process
    if approved?
      if card_payment?
        send_card_receipt
      elsif bank_payment?
        send_bank_receipt?
        queue_job_to_confirm_check_not_bounced_in_five_days
      else
        send_cash_receipt?
      end
      do_accounting
      do_reporting
      do_internal_notifications
    elsif declined? && !cash_payment? && recurring?
      disable_recurring_payments
    end
  end
end
 
class CardPayment < Payment
  def do_process
    process_with_card_processor
  end
end
 
class BankPayment
  def do_process
    process_with_bank_processor
  end
end
 
class CashPayment
  def do_process
    # NOOP
  end
end
```

```
class CardPayment
  def process
    save_record
    process_with_card_processor
    if approved?
      send_card_receipt
      do_accounting
      do_reporting
      do_internal_notifications
    elsif payment.declined? && payment.recurring?
      disable_recurring_payments
    end
  end
end
 
class BankPayment
  def process
    save_record
    process_with_bank_processor
    if approved?
      send_bank_receipt
      queue_job_to_confirm_check_not_bounced_in_five_days
      do_accounting
      do_reporting
      do_internal_notifications
    elsif payment.declined? && payment.recurring?
      disable_recurring_payments
    end
  end
end
 
class CashPayment
  def process
    save_record
    if approved?
      send_cash_receipt
      do_accounting
      do_reporting
      do_internal_notifications
    end
  end
end
```
