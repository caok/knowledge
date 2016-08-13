 Wikipedia lists 25 different Unicode characters which are classified as whitespace

```
str = "   Hello world\n   "
str.strip                       # => "Hello world"

str = "   Hello world\n   "
str.lstrip                      # => "Hello world\n   "
str.rstrip                      # => "   Hello world"

str = "   Hello world\n   "
str.strip!
str                             # => "Hello world"
```

特殊的空格符号
```
str = "   Chunky bacon\n    "
str.strip                       # => "Chunky bacon\n    "
str.codepoints.last(5)          # => [10, 32, 32, 32, 160]
"\u00A0".codepoints             # => [160]

str.gsub("\u00A0", "").strip    # => "Chunky bacon\n"
str.gsub(/\A[[:space:]]+|[[:space:]]+\z/, "")    # => "Chunky bacon\n"

str.gsub(/\A\s+|\s+\z/, "")     # => "Chunky bacon\n    "   \s不能替换全部的空格
```
