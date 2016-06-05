当我们使用system去执行其他的程序时, 如果我们拼错了函数名字，我们除了获得nil这样一个结果之外，得不到任何有用信息

```
system "pigmentize -o out.html in.html" # => nil
$?.exitstatus                   # => 127
```
127 means "command not found".


```
system "pigmentize -o out.html in.html 2>&1" # => false
# >> sh: 1: pigmentize: not found
```
标准的输入，输出和错误输出分别表示为STDIN,STDOUT,STDERR，也可以用0，1，2来表示。
cat food 2>&1 : 错误输出到终端

http://www.cnblogs.com/yangyongzhi/p/3364939.html

```
system "pigmentize -o out.html in.html 1>/dev/null"        # => false
# !> sh: 1: pigmentize: not found
```

```
system "pygmentize -o out.html in.html"

$ strace -f -e execve -e signal= -qq ruby goodcmd.rb
execve("/home/avdi/.rubies/ruby-2.3.0/bin/ruby", ["ruby", "goodcmd.rb"], [/* 79 vars */]) = 0
syscall_318(0x7ffd73c0e4c0, 0x10, 0, 0x55ba5d0fdf50, 0x55ba5d08fc20, 0) = 0x10
syscall_318(0x7ffd73c0ee80, 0x10, 0, 0x55ba5d0ce348, 0, 0x55ba5c698760) = 0x10
[pid 16538] execve("/usr/bin/pygmentize", ["pygmentize", "-o", "out.html", "in.html"], [/* 79 vars */])
= 0
```

```
system "pygmentize -o out.html in.html 2>&1"

$ strace -f -e execve -e signal= -qq ruby goodcmd-redir.rb
execve("/home/avdi/.rubies/ruby-2.3.0/bin/ruby", ["ruby", "goodcmd-redir.rb"], [/* 79 vars */]) = 0
syscall_318(0x7fff951e85f0, 0x10, 0, 0x560ef8264fa0, 0x560ef81f6c20, 0) = 0x10
syscall_318(0x7fff951e8fb0, 0x10, 0, 0x560ef8232370, 0, 0x560ef6138760) = 0x10
[pid  1735] execve("/bin/sh", ["sh", "-c", "pygmentize -o out.html in.html 2"...], [/* 79 vars */]) = 0
[pid  1736] execve("/usr/bin/pygmentize", ["pygmentize", "-o", "out.html", "in.html"], [/* 79 vars */])
= 0
```
What has happened is that we've run into one of Ruby's special "glue language" features. When we give ruby an external command to execute, Ruby first takes a look at the command. If it looks like a simple command with arguments, Ruby executes it directly. But, if Ruby sees any special shell syntax in the command, it does something different. It instead starts a subshell, so that the shell program can correctly interpret the shell syntax. That's why, when we added a shell redirect to the command, we suddenly started seeing two subprocesses instead of just one.
This feature can make life easier for converting system automation shell scripts to Ruby scripts, since it means that a lot of complex shell commands will "just work". But if we aren't expecting this behavior it can lead to confusion, bugs, and even security vulnerabilities.

```
system "cowsay \"Want to make some money?\""

 __________________________
< Want to make some money? >
 --------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

system "cowsay \"Want to make some $$$?\""

 _________________________
< Want to make some 60810 >
 -------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```
"$$" is a shell special variable referring to the current process ID. 
"$?" is the exit value of the last executed command

Ruby saw something in the command that it interpreted as shell syntax. Specifically, "dollar dollar" is a shell special variable referring to the current process ID. And "dollar question" is the exit value of the last executed command, if any. By "helpfully" running this command inside a shell process, Ruby wound up breaking our script.

```
message = "Bye bye!\"; rm cowsay-malicious.rb; echo \""
system "cowsay \"#{message}\""
```
不安全，会直接删除文件

这样做更加安全，不会取执行"/bin/sh"
```
message = "Bye bye!\"; rm cowsay-safe.rb; echo \""
system("cowsay", message)

$ strace -f -e execve -e signal= -qq ruby cowsay-safe.rb
execve("/home/avdi/.rubies/ruby-2.3.0/bin/ruby", ["ruby", "cowsay-safe.rb"], [/* 79 vars */]) = 0
syscall_318(0x7ffe34f7a860, 0x10, 0, 0x55cfffc17eb0, 0x55cfffba9c20, 0) = 0x10
syscall_318(0x7ffe34f7b220, 0x10, 0, 0x55cfffbe6368, 0, 0x55cffda0a760) = 0x10
[pid 23066] execve("/usr/games/cowsay", ["cowsay", "Bye bye!\"; rm cowsay-safe.rb; ec"...], [/* 79 vars
*/]) = 0
 ______________________________________
< Bye bye!"; rm cowsay-safe.rb; echo " >
 --------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```


system([env,] command... [,options]) → true, false or nil
commandline                 : command line string which is passed to the standard shell
cmdname, arg1, ...          : command name and one or more arguments (no shell)
