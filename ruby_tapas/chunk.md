```
FILES = [
"AcmeCo",
"Beeblebrox",
"Breakfast",
"Cats",
"Chunky Bacon",
"X-Windows",
"Cthulhu",
"Delicatessens",
"Ducks",
# ...
]

FILES.map{|f| f[0]}
# => ["A", "B", "B", "C", "C", "C", "D", "D"]

FILES.chunk{|f| f[0]}
# => #<Enumerator: ...>

FILES.chunk{|f| f[0]}.to_a
# => [["A", ["AcmeCo"]], ["B", ["Beeblebrox", "Breakfast"]], ["C", ["Cats", "Chunky Bacon", "Cthulhu"]], ["D", ["Delicatessens", "Ducks"]]]
```

```
FILES.group_by{|f| f[0]}
#=> {"A"=>["AcmeCo"], "B"=>["Beeblebrox", "Breakfast"], "C"=>["Cats", "Chunky Bacon", "Cthulhu"], "X"=>["X-Windows"], "D"=>["Delicatessens", "Ducks"]}
FILES.chunk{|f| f[0]}.to_a
=> [["A", ["AcmeCo"]], ["B", ["Beeblebrox", "Breakfast"]], ["C", ["Cats", "Chunky Bacon"]], ["X", ["X-Windows"]], ["C", ["Cthulhu"]], ["D", ["Delicatessens", "Ducks"]]]
```

```
code = <<EOF
  total = 123 + 456
  print total
EOF

code.chars.chunk{|c|
  case c
  when /\n/ then :endline
  when /\s/ then :whitespace
  when /[[:alpha:]]/ then :identifier
  when /[\+\-\=\/\*]/ then :operator
  when /\d/ then :number
  end
}.to_a

=> [[:identifier, ["t", "o", "t", "a", "l"]], [:whitespace, [" "]], [:operator, ["="]], [:whitespace, [" "]], [:number, ["1", "2", "3"]], [:whitespace, [" "]], [:operator, ["+"]], [:whitespace, [" "]], [:number, ["4", "5", "6"]], [:endline, ["\n"]], [:identifier, ["p", "r", "i", "n", "t"]], [:whitespace, [" "]], [:identifier, ["t", "o", "t", "a", "l"]], [:endline, ["\n"]]]
```

```
code = <<EOF
total = 123 + 456
print total
EOF
 
code.chars.chunk{|c|
  case c
  when /\n/ then :endline
  when /\s/ then :_separator
  when /[[:alpha:]]/ then :identifier
  when /[\+\-\=\/\*]/ then :operator
  when /\d/ then :number
  end
}.to_a

=> [[:identifier, ["t", "o", "t", "a", "l"]], [:operator, ["="]], [:number, ["1", "2", "3"]], [:operator, ["+"]], [:number, ["4", "5", "6"]], [:endline, ["\n"]], [:identifier, ["p", "r", "i", "n", "t"]], [:identifier, ["t", "o", "t", "a", "l"]], [:endline, ["\n"]]]
```
"_separator"是特殊的？使用其他的_aaa会报错

nil and :_separator specifies that the elements should be dropped.
:_alone specifies that the element should be chunked by itself.

Returning nil is treated the same was as returning the :_separator flag.
```
code.chars.chunk{|c|
  case c
  when /\n/ then :endline
  when /\s/ then nil
  when /[[:alpha:]]/ then :identifier
  when /[\+\-\=\/\*]/ then :operator
  when /\d/ then :number
  end
}.to_a

=> [[:identifier, ["t", "o", "t", "a", "l"]], [:operator, ["="]], [:number, ["1", "2", "3"]], [:operator, ["+"]], [:number, ["4", "5", "6"]], [:endline, ["\n"]], [:identifier, ["p", "r", "i", "n", "t"]], [:identifier, ["t", "o", "t", "a", "l"]], [:endline, ["\n"]]]
```
case中如果没有match上会自动返回nil, 所以
```
code = <<EOF
total = 123 + 456
print total
EOF
 
code.chars.chunk{|c|
  case c
  when /\n/ then :endline
  when /[[:alpha:]]/ then :identifier
  when /[\+\-\=\/\*]/ then :operator
  when /\d/ then :number
  end
}.to_a
```

```
code = <<EOF
bool = !!result
EOF
 
code.chars.chunk{|c|
  case c
  when /\n/ then :endline
  when /[[:alpha:]]/ then :identifier
  when /[\!\+\-\=\/\*]/ then :operator
  when /\d/ then :number
  end
}.to_a

=> [[:identifier, ["b", "o", "o", "l"]], [:operator, ["="]], [:operator, ["!", "!"]], [:identifier, ["r", "e", "s", "u", "l", "t"]], [:endline, ["\n"]]]
```
:_alone specifies that the element should be chunked by itself.

```
code = <<EOF
bool = !!result
EOF
 
code.chars.chunk{|c|
  case c
  when /\n/ then :endline
  when /[[:alpha:]]/ then :identifier
  when /[\!\+\-\=\/\*]/ then :_alone
  when /\d/ then :number
  end
}.to_a

=> [[:identifier, ["b", "o", "o", "l"]], [:_alone, ["="]], [:_alone, ["!"]], [:_alone, ["!"]], [:identifier, ["r", "e", "s", "u", "l", "t"]], [:endline, ["\n"]]]
```

```
require 'stringio'
data = "6\r\nHello!\r\nD\r\n How are\r\n you?\r\n0\r\n"
chunked_data = StringIO.new(data)

chunks = chunked_data
         .each_line("\r\n")
         .chunk({chunk_num: 0, chars_left: :unknown}){ |line, state|
  line.chomp!("\r\n")
  if state[:chars_left] == :unknown
    state[:chars_left] = Integer(line, 16)
    :_separator
  elsif state[:chars_left] > 0
    state[:chars_left] -= line.size
    state[:chunk_num]
  else
    state[:chunk_num] += 1
    state[:chars_left] = :unknown
    redo
  end
}

chunks.next                     # => [0, ["Hello!"]]
chunks.next                     # => [1, [" How are", " you?"]]
```
