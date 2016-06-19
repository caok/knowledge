```
PRICING = {
  "bread"  => 2_30,
  "milk"   => 3_82,
  "eggs"   => 2_97,
  "juice"  => 2_98,
  "cheese" => 6_00,
}

belt = %w[ juice eggs milk bread eggs cheese juice milk bread ]

belt.map{|item| PRICING[item]}
# => [298, 297, 382, 230, 297, 600, 298, 382, 230]
```

##lambda
```
#定义
square = lambda do |n|
  n ** 2
end

square = ->(n) { return n ** 2 }

调用
square.call(2)
square[2]
```

```
#lambda
pricing = ->(item){
  case item
  when "bread" then 2_30
  when "milk" then 3_82
  when "eggs" then 2_97
  when "juice" then 2_98
  when "cheese" then 6_00
  end
}

pricing["bread"]                # => 230
pricing["juice"]                # => 298
```

ruby 2.3
```
belt = %w[ juice eggs milk bread eggs cheese juice milk bread ]

RUBY_VERSION                    # => "2.3.0"
belt.map(&PRICING)

=> [298, 297, 382, 230, 297, 600, 298, 382, 230]
相当于
belt.map{|t| PRICING.to_proc.call(t)}

pricer = PRICING.to_proc
# => #<Proc:0x005557fcdd0618>
pricer.call("eggs")             # => 297
pricer.call("cheese")           # => 600

belt.uniq.sort_by(&PRICING)
# => ["bread", "eggs", "juice", "milk", "cheese"]
等同于
belt.uniq.sort_by(&pricing)
```
