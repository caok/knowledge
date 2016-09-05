```
42.to_s                         # => "42"
42.to_s(16)                     # => "2a"
42.to_s(8)                      # => "52"
42.to_s(2)                      # => "101010"

#In fact, we can specify any base between 2 and 36. If for some reason we wanted to.

42.to_s(24)                     # => "1i"
42.to_s(36)                     # => "16"
```

```
"2A".to_i(16)                   # => 42
"101010".to_i(2)                # => 42
"16".to_i(36)                   # => 42
```

```
"a bajillion".to_i              # => 0
Integer("42")                   # => 42
Integer("a bajillion")          # => ArgumentError: invalid value for Integer(): "a bajillion"
```
使用integer能对其做一定的检查
```
Integer("2A", 16)               # => 42
Integer("0x2A", 16)             # => 42

Integer("0x2A", 8)              # =>
 
# ~> ArgumentError
# ~> invalid value for Integer(): "0x2A"
```
