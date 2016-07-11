```
ids = [23, 48, 17, 6, 39]
new_id = ids.max + 1            # => 49

#This works great, until one day we start from a blank list of current IDs. This time, it blows up.

ids = []
new_id = ids.max + 1            # =>
# ~> NoMethodError
# ~> undefined method `+' for nil:NilClass
# ~>
# ~> xmptmp-in30752pYg.rb:2:in `<main>'

[].max                          # => nil


nil.to_i                        # => 0
nil.to_f                        # => 0.0
nil.to_s                        # => ""
nil.to_a                        # => []
nil.to_h                        # => {}


ids = [23, 48, 17, 6, 39]
new_id = ids.max.to_i + 1     # => 49

ids = []
new_id = ids.max.to_i + 1     # => 1
```
