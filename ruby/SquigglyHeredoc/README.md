## 多行字符串

```
str  = "'twas brillig and the slithy toves
did gyre and gimbal in the wabe
all mimsy were the borogroves
and the mome raths, outgrabe"

# 对含有引号的情况，不是很友好

str = "'twas brillig and the slithy toves
did gyre and gimbal in the wabe
all mimsy were the borogroves
and the mome raths, outgrabe

\"Beware the Jabberwock, my son\""
```

```
str  = %{'twas brillig and the slithy toves
did gyre and gimbal in the wabe
all mimsy were the borogroves
and the mome raths, outgrabe

"Beware the Jabberwock, my son"}

# ----------or------------
str  = %|'twas brillig and the slithy toves
did gyre and gimbal in the wabe
all mimsy were the borogroves
and the mome raths, outgrabe

"Beware the Jabberwock, my son"|

str = %{
  'twas brillig and the slithy toves
  did gyre and gimbal in the wabe
  all mimsy were the borogroves
  and the mome raths, outgrabe

  "Beware the Jabberwock, my son"
}

str
# => "\n  'twas brillig and the slithy toves\n  did gyre and gimbal in the wabe\n  all mimsy were the borogroves\n  and the mome raths, outgrabe\n\n  \"Beware the Jabberwock, my son\"\n"
```

首行是空行，即有"\n"


### Here Document
```
<<结束标识符
字符串内容
结束标识符
```
一般用EOF或EOB作为结束标识符
```
str = <<EOF
  'twas brillig and the slithy toves
  did gyre and gimbal in the wabe
  all mimsy were the borogroves
  and the momraths, outgrabe

  "Beware the Jabberwock, my son"
EOF

str
# => "  'twas brillig and the slithy toves\n  did gyre and gimbal in the wabe\n  all mimsy were the borogroves\n  and the momraths, outgrabe\n\n  \"Beware the Jabberwock, my son\"\n\n  2\n"

str = <<EOF.upcase
  'twas brillig and the slithy toves
  did gyre and gimbal in the wabe
  all mimsy were the borogroves
  and the momraths, outgrabe

  "Beware the Jabberwock, my son"
EOF

str
# => "  'TWAS BRILLIG AND THE SLITHY TOVES\n  DID GYRE AND GIMBAL IN THE WABE\n  ALL MIMSY WERE THE BOROGROVES\n  AND THE MOMRATHS, OUTGRABE\n\n  \"BEWARE THE JABBERWOCK, MY SON\"\n"

answer = <<EOF
one plus one is #{1 + 1}
EOF

answer                          # => "one plus one is 2\n"
```

```
2.times do
  puts <<EOF
    this is the first line
      this is the second line
  EOF
end
# 无法成功解析, 被认为没有结束

2.times do
  puts <<EOF
    this is the first line
      this is the second line
EOF
end
#EOF必须在行首, 导致缩进乱掉

# 如果希望缩进整齐，可以使用<<- 代替 <<
2.times do
  puts <<-EOF
    this is the first line
      this is the second line
  EOF
end
#注意输出时的缩进情况

#2.3中支持~
2.times do
  puts <<~EOF
    this is the first line
      this is the second line
  EOF
end
```

#https://ruby-china.org/topics/25983
