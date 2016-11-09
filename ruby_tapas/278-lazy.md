According to Larry Wall, laziness is one of the three virtues of programming, along with impatience and hubris

我们想要得到系统字典的前100个单词
```
open('/usr/share/dict/words').readlines.first(100)
```
作者非常喜欢Enumerators， Enumerators are often a way to iterate over some stream or collection in a lazy fashion.
我们这里可以使用each_line，当不通过block去调用它时，它会返回一个Enumerator,ruby不会真正的将每一行都读出来, 但它准备好了，它会读取仅它需要的, 即first(100)才真正去读取，而且只读前100行
```
enum = open('/usr/share/dict/words').each_line
# => #<Enumerator: #<File:/usr/share/dict/words>:each_line>
 
enum.first(100)
```

### only doing as much work as necessary

```
require "prime"
 
Prime.each do |n|
  puts n
end
```

```
require "prime"
 
enum = Prime.each               # => #<Prime::EratosthenesGenerator:0x2614f98 @last_prime_index=-1, @ubound=nil>
 
enum.next                       # => 2
enum.next                       # => 3
enum.next                       # => 5
```
laziness is important not just to avoid unnecessary work. We need it in order to avoid an infinite iteration.
懒惰是重要的不只是为了避免不必要的工作。我们需要它，以避免无限循环。

前十个数的平方数
```
1.step                          # => #<Enumerator: 1:step>
1.step.first(10).map{|n| n}
# => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
1.step.first(10).map{|n| n**2}
# => [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```

```
def squares(size)
  1.step.first(size).map{|n| n**2}
end
 
squares(5)
# => [1, 4, 9, 16, 25]
```
换种方式
```
1.step                          # => #<Enumerator: 1:step>
1.step.lazy                     # => #<Enumerator::Lazy: #<Enumerator: 1:step>>
squares = 1.step.lazy.map{|n| n**2}       # => #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator: 1:step>>:map>
squares.first(8)
# => [1, 4, 9, 16, 25, 36, 49, 64]
```
need pairs of two consecutive squares
```
squares = 1.step.lazy.map{|n| n**2}.each_slice(2)
# => #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator: 1:step>>:map>:each_slice(2)>
 
squares.first(4)
# => [[1, 4], [9, 16], [25, 36], [49, 64]]
```
