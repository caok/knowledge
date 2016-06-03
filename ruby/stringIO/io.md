ruby程序在启动后会预先分配3个IO对象
1.标准输入
2.标准输出
3.标准错误输出


## 文件输入和输出
```
io = File.open(file, mode)
io = open(file, mode)
```
默认为只读模式
```
io.close
```
1个程序中同事打开文件的数量是有限制的，所以使用完的文件应尽快关闭。若打开的文件过多，程序可能会在调用open的出现异常

File.open方法如果使用块，则文件会在使用完毕后自动关闭, 推荐使用
```
File.open('foo.txt') do |io|
  while line = io.gets
    ...
  end
end
```

检查io对象是否关闭
```
io = File.open('foo.txt')
io.close
p io.closed?  #=> true
```
```
File.read('foo.txt')  #一次性读取文件的内容
```

## 输入操作
```
File.open('foo.txt') do |io|
  while line = io.gets
    line.chomp! #删除字符串末尾的换行符
    ...
  end
  p io.eof?     #检查输入是否已经完毕
end

or

io.each_line do |line|
  line.chomp!
  ...
end

# readlines 可以一次性读取所有的数据，并返回将每行数据作为元素封装的数组
ary = io.readlines
ary.each_line do |line|
  line.chomp!
  ...
end
```

```
io.each_char   #逐个字符的读取io中的数据
io.each_byte   #逐个字节的读取io中的数据
io.getc        #只读取io中的一个字符
io.getbyte
io.read(size)  #不指定大小时，则一次性读取全部数据并返回
```

## 输出操作
```
$stdout.puts "foo", "bar"    #对字符串末尾添加换行符后输出，指定多个参数时，会分别添加换行符
$stdout.putc('Ruby')         #参数为字符串时输出首字符
io.print
io.printf                    #按照指定的格式输出字符串
io.write(str)
io<<str
```

## 文件指针
我们用文件指针来表示IO对象指向的文件的位置。每当读写文件时，文件指针都会自动移动，而我们也可以使文件指针指向任意位置来读写数据
```
io.pos   #获得文件指针现在的位置，也可以通过pos＝来改变指针位置

File.open('hello.txt') do |io|
  p io.read(5)    #=> "hello"
  p io.pos        #=> 5
  io.pos = 0
  p io.gets       #=> "hello, ruby.\n"
end

io.seek           #移动文件指针
io.rewind         # 将文件指针返回到文件的开头

io.truncate(size) #按照size指定的大小来截断文件
io.truncate(0)        # 将文件大小置为0
io.truncate(io.pos)   # 删除当前文件指针以后的数据
```

## stringIO
