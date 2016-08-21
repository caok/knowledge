```
class Point
  def initialize(x, y)
    @x, @y = x, y
  end
 
  def inspect
    "Point(#{@x}x#{@y})"
  end
end
 
Point.new(42, 23)               # => Point(42x23)
```

ruby 2.0
```
class Point
  def initialize(x:, y:)
    @x, @y = x, y
  end
 
  def inspect
    "Point(#{@x}x#{@y})"
  end
end
 
Point.new(x: 2, y: 3)           # => Point(2x3)
Point.new(42, 23)               # =>
 
# ~> ArgumentError
# ~> missing keywords: x, y
```

```
class Point
  def initialize(_x=nil, _y=nil, x: _x, y: _y)
    @x, @y = x, y
  end
 
  def inspect
    "Point(#{@x}x#{@y})"
  end
end
 
Point.new(42, 23)               # => Point(42x23)
Point.new(x: 2, y: 3)           # => Point(2x3)
Point.new                       # => Point(x)
```

增加一个参数的检查
```
class Point
  def initialize(_x=nil, _y=nil, x: _x, y: _y)
    x && y or raise ArgumentError, "Must supply X and Y coordinates"
    @x, @y = x, y
  end
 
  def inspect
    "Point(#{@x}x#{@y})"
  end
end
```
