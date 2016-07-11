```
start_time = Time.now
1_000_000.times do
  2 + 2
end
result = Time.now - start_time
result                          # => 0.041977537
```

### Ruby Benchmark standard library
#### measure
measure 方法用来测量它后面的代码块的执行速度
```
require "benchmark"

result = Benchmark.measure {
  1_000_000.times do
    2 + 1
  end
}
result
# => #<Benchmark::Tms:0x007fa6d441b770 @label="", @real=0.03199431199936953, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.03, @total=0.03>

puts result
# =>   0.030000   0.000000   0.030000 (0.031994)
(1) User CPU Time: CPU time spent processing instructions from your userland code
(2) System CPU Time: CPU time spend processing instructions form kernel code
(3) User CPU Time + System CPU Time
(4) Elapsed real time: Timefeom start to finish as measured by a regular clock
```

#### bm
bm 创建一个 Report 对象并使用它调用代码块
```
require 'benchmark'

n = 5000000
Benchmark.bm do |x|
  x.report { for i in 1..n; a = "1"; end }
  x.report { n.times do   ; a = "1"; end }
  x.report { 1.upto(n) do ; a = "1"; end }
end

# => 
    user     system      total        real
    1.010000   0.000000   1.010000 (  1.014479)
    1.000000   0.000000   1.000000 (  0.998261)
    0.980000   0.000000   0.980000 (  0.981335)
```

增加label
```
require 'benchmark'

n = 5000000
Benchmark.bm(2) do |x|
  x.report("for:")   { for i in 1..n; a = "1"; end }
  x.report("times:") { n.times do   ; a = "1"; end }
  x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
end

# =>
              user     system      total        real
for:      1.010000   0.000000   1.010000 (  1.015688)
times:    1.000000   0.000000   1.000000 (  1.003611)
upto:     1.030000   0.000000   1.030000 (  1.028098)
```

#### bmbm
```
require 'benchmark'

array = (1..1000000).map { rand }

Benchmark.bmbm do |x|
  x.report("sort!") { array.dup.sort! }
  x.report("sort")  { array.dup.sort  }
end
```

####参考
* https://dzone.com/articles/how-do-i-benchmark-ruby-code
* https://rubytapas.dpdcart.com/subscriber/post?id=831
* http://www.tuicool.com/articles/6ZzYNn
