```
s = gets
puts s.upcase
```

却少一个输入提示不友好
```
puts "> "
s = gets
puts s.upcase
```

用puts的话，会换行，所以>和输入的内容不在同一行
```
print "> "
s = gets
puts s.upcase
```

将其放入循环中
```
loop do
  print "> "
  input = gets
  puts "Input was: #{input.inspect}"
end
```

Control-D 时gets返回一个nil
assuming we are using a typical UNIX-style terminal, when we hit Ctrl-D, the terminal interprets that as a command to send the “End-Of-File”, or EOF, indicator to the process. And gets has special handling for EOF: it returns nil.
```
loop do
  print "> "
  input = gets
  puts "Input was: #{input.inspect}"
  break if input.nil?
end
```

```
print "> "
while input = gets do
  puts "Input was: #{input.inspect}"
  print "> "
end
```

```
while (print "> "; input = gets) do
  puts "Input was: #{input.inspect}"
end
```

消除'\n'
```
while (print "> "; input = gets) do
  input.chomp!
  puts "Input was: #{input.inspect}"
end
```

```
while (print "> "; input = gets) do
  input.chomp!
  puts "Input was: #{input.inspect}"
  case input
  when "time" then puts Time.now
  when "quit", "exit" then break
  else puts "I don't know that command"
  end
end
```
