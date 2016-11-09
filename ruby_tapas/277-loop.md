```
require 'socket'
 
server = TCPServer.new 9001
 
while true do
  client = server.accept
  input = client.readline.chomp
  client.puts input.reverse
  client.close
end
```

```
require 'socket'
 
server = TCPServer.new 9001
 
loop do
  client = server.accept
  input = client.readline.chomp
  client.puts input.reverse
  client.close
end
```
如果使用while的话，会有意识的去寻找condition， 但如果是loop， 那么它就是个无限循环(loop)

调用loop但不接一个block的话，则返回一个Enumerator
```
enum = loop                     # => #<Enumerator: main:loop>
enum.next                       # => nil
enum.next                       # => nil
enum.next                       # => nil
```

loop和while的区别
```
while true
  foo = 42
  break
end
 
foo                             # => 42
```

```
loop do
  foo = 42
  break
end
 
foo                             # =>
 
# ~> NameError
# ~> undefined local variable or method `foo' for main:Object
```
Like any block, the block passed to loop has its own variable scope. Whereas a while loop doesn’t introduce any new scopes.
Ruby can’t find the block-local variable in the outer context.

但如果要让loop达到while同样的效果，可以这么做
```
foo = nil
loop do
  foo = 42
  break
end
 
foo                             # => 42
```
