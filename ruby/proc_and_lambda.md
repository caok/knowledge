## Proc and Lambda

### Proc
Proc是使block对象化的类
```
p = Proc.new { puts "Hello!" }
p.call # Output: Hello!

p = Proc.new do
  print "Hello! "
  print "Goodbye!"
end

p = proc do
  print "Hello!"
end
p.call # Output: Hello! Goodbye!
```

带参数的proc
```
p = Proc.new { |name| puts "Hello, #{name}!" }
p.call # Output: Hello, !
```
调用
```
p.call 'Clark'
p["Clark"]
p.("Clark")
p::("Clark")
p === "Clark"
p.yield "Clark"
```



### Lambda
lambda是定义在Kernel中的函数，因此它的作用域是全局的。使用lambda用来创建闭包的方式和使用Proc非常类似,lambda和proc除了两个关键的不同之处外几乎是一样的。
```
l = lambda { puts "Hello" }
l.call # Output: Hello

l = ->{ puts "Hello!" }
l.call # Output: Hello!
```
带参数的lambda
```
l = lambda { |name| puts "Today we will practice #{name} meditation." }
l.call "zazen" # Output: Today we will practice Zazen meditation.

l = -> (name) { puts "Today we will practice #{name} meditation." }
l.call "zazen" # Output: Today we will practice Zazen meditation.
```
调用
```
l.call 'Clark'
l["Clark"]
l.("Clark")
l::("Clark")
l === "Clark"
l.yield "Clark"
```

与proc的两个不同点
1.lambda的参数数量检查更加严格
2.lambda可以使用return将值从块中返回

* In a lambda-created proc, the return statement returns only from the proc itself
* In a Proc.new-created proc, the return statement is a little more surprising: it returns control not just from the proc, but also from the method enclosing the proc!
lambda的return是返回值给方法，方法会继续执行；Proc的return会终止方法并返回得到的值。
```
def whowouldwin
  mylambda = lambda {return "Freddy"}
  mylambda.call

  # mylambda gets called and returns "Freddy", and execution
  # continues on the next line

  return "Jason"
end

whowouldwin
=> "Jason"



def whowouldwin2
  myproc = Proc.new {return "Freddy"}
  myproc.call

  # myproc gets called and returns "Freddy", 
  # but also returns control from whowhouldwin2!
  # The line below *never* gets executed.

  return "Jason"
end

whowouldwin2         
=> "Freddy"
```

所以通过lambda创建的proc的行为会更接近方法


### 参考
* http://caok1231.com/ruby/2013/02/23/blocks-procs-lambdas.html
* http://www.zenruby.info/2016/05/procs-and-lambdas-closures-in-ruby.html?utm_source=rubyweekly&utm_medium=email
* https://stackoverflow.com/questions/626/when-to-use-lambda-when-to-use-proc-new
