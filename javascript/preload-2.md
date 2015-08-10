## 从function的定义看JavaScript的预加载

在JavaScript中定义一个函数，有两种写法：
```
function ftn(){} // 第一种
var ftn = function(){} // 第二种
```

有人说，这两种写法是完全等价的。但是在解析前，前一种写法会被解析器自动提升到代码的头部，因此违背了函数先定义后使用的原则，所以建议定义函数时候，全部采用后一种写法。

看完这句话，我第一个感觉是两个在使用时候是完全一致的，只是解析上有所差异。但是他的解释“前一种写法会被解析器自动提升到代码的头部”让我很困惑。

如是我有了下面第一个测试：
```
<script type="text/javascript">
function ftn()
{
  alert('old');
}

var b = ftn;

function ftn()
{
  b();
  alert('new');
}

ftn();//浏览器报内存溢出
</script>
```

接下来我做了第二个测试：
```
<script type="text/javascript">
var ftn = function()
{
  alert('old');
}

var b = ftn;

var ftn = function()
{
  b();
  alert('new');
}

ftn();//old,new依次弹出
</script>
```

网上的对这个解释是：第一种方式，刚开始其实没有重新定义ftn这个Function而在里面执行了其本身。第二种方式，ftn=function()这里没有执行到Function里面的代码ftn已经被重新定义了，所以这里的重定义是有效的。

如果不怎么清楚，那么我再做了一个下面的测试：
```
<script type="text/javascript">
function ftn()
{
  alert('old');
}

var b = ftn;

function ftn()
{
  b();
  alert('new');
}

alert(b);//结果是重新定义的ftn内容
</script>
```

测试结果发现，重新定义ftn后，b的内容也会随着改变。下面我又做了两外一个测试：
```
<script type="text/javascript">
var ftn = function()
{
  alert('old');
}

var b = ftn;

var ftn = function()
{
  b();
  alert('new');
}

alert(b);//结果是老的ftn内容
</script>
```

这样就很有意思了，在JavaScript里面除了基本数据类型，其他类型都是对象，对象是存在堆里面，它的别名是存在栈里面的地址，后一种测试很明显可以用这样的原理来理解。那么前面的测试为什么b会随着ftn的重新定义而改变了？

我有一种新解释，不知道对不对，在所有的讲JavaScript书里都会提到，JavaScript里面是没有方法重载的，后面定义的重名function会覆盖前面的function，var b = ftn;这句话是把b和ftn的引用指向同一个堆里面的内存，而重新定义function ftn(){}后，新的function对象覆盖了老的对象，而b和ftn引用的堆地址空间没变，如果真是这样，那么这种写法就合理了：
```
<script type="text/javascript">
function ftn()
{
  alert('old');
}

var b = ftn;

var ftn = function()
{
  b();
  alert('new');
}

alert(b);//老的ftn
alert(ftn);//新的ftn
ftn();//old ,new
</script>
```

这样新的ftn在栈里面的地址改变了，指向了新的function对象的定义，而原来的function没有被覆盖，还保存，所以b还是老的ftn引用的地址。

刚刚写了一篇对JavaScript里面function理解的文章，回头再思考下我这边文章的内容，觉得自己通过测试的结果的理解还是有点问题，其实理解还是要从编译，运行的原理进行思考。JavaScript都是在执行代码时候才编译代码，因此我们var定义的类型可以不定，我们封装的对象还时候添加属性和方法，因此可以这么理解我标题所带来的问题，javascript一般的语言，例如定义一个变量var obj = new Object()只是做了一个很初的处理，在JavaScript里面叫做预编译，这种预编译的能力很弱，弱到你可以随便更改，而不会影响程序的运行，当对象被调用时候，JavaScript解释器才会进行编译，然后运行代码，这和java很不一样，java是先把代码编译好，调用他的时候才运行，这就是脚本语言的特点，所以脚本语言大多不快。但是当你这么定义函数：fonction ftn(){},这种就把代码进行了编译，也就是执行过了，这种写法和java函数的定义很相似了。这是我的新解，我觉得这个解释更加合理些。

JavaScript的“编译”只是检查有没有代码错误，不会运行代码，你可以试试在function里面随便写东西测试一下。预加载，先是function，再是var。上面的代码中，只有demo1和demo3受到影响，demo1和demo3的源代码顺序function - var - function，应用预加载后的顺序：function - function - var，预加载后的完整代码：
```
<script type="text/javascript">
//demo1
function ftn()
{
    alert('old');
}
function ftn()
{
    b();
    alert('new');
}
var b = ftn;

ftn();//浏览器报内存溢出
</script>
```

```
<script type="text/javascript">
//demo3
function ftn()
{
  alert('old');
}
function ftn()
{
  b();
  alert('new');
}
var b = ftn;

alert(b);//结果是重新定义的ftn内容
</script>
```

预加载大概就这么样了。
