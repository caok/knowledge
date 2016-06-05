# The difference between dup and clone in Ruby

### 1.clone会复制原对象的FL_FREEZE标志位，而dup不会
```
str = 'ruby'
str.freeze

str.dup.frozen?       # => false
str.clone.frozen?     # => true
```

### 2.clone会拷贝singleton methods, 而dup不会
```
obj = Object.new
# #<Object:0x007fd214a36018>

def obj.say_hi
  puts 'Hi'
end
# :say_hi

obj.say_hi
# Hi

obj.dup.say_hi
# NoMethodError: undefined method `say_hi' for #<Object:0x007fd2142297a8>

obj.clone.say_hi
# Hi
```

```
obj1 = Struct.new(:val).new('hello')
# => #<struct  val="hello">

obj1.val.object_id
# => 23411500
(obj2 = obj1.dup).val.object_id
# => 23411500
(obj3 = obj1.clone).val.object_id
# => 23411500

[obj1, obj2, obj3].map(&:object_id)
# => [23411480, 23968080, 24156660]
```

```
Ruby 提供了 3 个在复制对象时会被调用的回调函数：

Object#initialize_copy
Object#initialize_dup
Object#initialize_clone
```

```
当 dup 或 clone 时的步骤如下：
1.先分配内存。
2.创建新的对象。
3.设置 GC。
4.以原对象为参数，调用新对象相应的 initialize_dup 或 initialize_clone 方法，若该方法不存在，则调用 initialize_copy 方法。
5.如果是 clone ，则设置新对象冻结标记位。
```
