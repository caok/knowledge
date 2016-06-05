取出0-50之间的数字
```
[87, 23, 15, 74, 62, 42, 91].select {|n| n>=0 && n<=50}
[87, 23, 15, 74, 62, 42, 91].select {|t| (0..50) === t}
[87, 23, 15, 74, 62, 42, 91].grep(0..50)
# => [23, 15, 42]
```

取出0-50之外的数字
```
irb(main):010:0> (0..50) === 23
=> true
irb(main):011:0> (0..50) === 51
=> false

[87, 23, 15, 74, 62, 42, 91].reject {|n| (0..50) === n }.each do |e|
  puts e
end
# >> 87
# >> 74
# >> 62
# >> 91

[87, 23, 15, 74, 62, 42, 91].select {|t| not (0..50) === t}
```

```
inverted = ->(n) { not (0..50) === n}

[87, 23, 15, 74, 62, 42, 91].grep(inverted) do |e|
  puts e
end
```

ruby2.3中加入了grep_v的方法，ruby2.2中还没
```
[87, 23, 15, 74, 62, 42, 91].grep_v(0..50) do |e|
  puts e
end
```

```
invert_results = true
message = invert_results ? :grep_v : :grep
[87, 23, 15, 74, 62, 42, 91].public_send(message, 0..50) do |e|
  puts e
end

# >> 87
# >> 74
# >> 62
# >> 91
```

https://zigzag.github.io/2010/03/31/grep-in-ruby----a-powerful-enumerable-method.html
