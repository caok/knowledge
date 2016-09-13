```
Request = Struct.new(:from, :task)
 
REQUESTS = [
  Request.new("Snowball", "Build a bigger slop trough"),
  Request.new("Boxer", "Clean the hay cart"),
  Request.new("Napoleon", "Build a whisky still"),
  Request.new("Benjamin", "Re-stock the library"),
]
```

```
require "./requests"
REQUESTS.select{|r| ["Snowball", "Napoleon", "Squealer"].include?(r.from)}

require "./requests"
REQUESTS.reject{|r| ["Snowball", "Napoleon", "Squealer"].include?(r.from)}
```

```
require "./requests"
 
priority, rest = REQUESTS.partition{ |r|
  ["Snowball", "Napoleon", "Squealer"].include?(r.from)
}
priority
# => [#<struct Request from="Snowball", task="Build a bigger slop trough">, #<struct Request from="Napoleon", task="Build a whisky still">]
rest
# => [#<struct Request from="Boxer", task="Clean the hay cart">, #<struct Request from="Benjamin", task="Re-stock the library">]
```
