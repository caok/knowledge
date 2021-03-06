## 7.重定向

重定向标准输出，把运行结果输送到文件 ls-output.txt 中去， 由文件代替屏幕

```shell
ls -l /usr/bin > ls-output.txt
```

删除一个已存在文件的内容或是 创建一个新的空文件(会替换原先的内容)
```shell
> ls-output.txt
```

追加

```shell
ls -l /usr/bin >> ls-output.txt
```

#### 重定向标准错误

```shell
ls -l /bin/usr 2> ls-error.txt
```

#### 重定向标准输出和错误到同一个文件

```shell
ls -l /bin/usr > ls-output.txt 2>&1
```

首先重定向标准输出到文件 ls-output.txt，然后 重定向文件描述符2（标准错误）到文件描述符1（标准输出）使用表示法2>&1。注意**重定向的顺序**安排非常重要。标准错误的重定向必须总是出现在标准输出 重定向之后，要不然它不起作用

```shell
ls -l /bin/usr &> ls-output.txt
```

**/dev/null**的文件。这个文件是系统设备，叫做位存储桶，它可以 接受输入，并且对输入不做任何处理。为了隐瞒命令错误信息，我们这样做：

```shell
ls -l /bin/usr 2> /dev/null
```

#### cat

```shell
cat > lazy_dog.txt
```

输入命令，其后输入要放入文件中的文本。最后输入 Ctrl-d结束

```shell
cat < lazy_dog.txt
cat lazy_dog.txt
```

效果一样，使用“<”重定向操作符，把标准输入源从键盘改到文件 lazy_dog.txt

```shell
ls /bin /usr/bin | sort | uniq -d | less
```

管道线， 过滤器(sort)

```shell
ls /bin /usr/bin | sort | uniq | wc -l
```

wc  行数，单词数和字节数, '-l'只输出行数

```shell
ls /bin /usr/bin | sort | uniq | grep zip
```

```shell
tail -f /var/log/messages
```

使用”-f”选项，tail 命令继续监测这个文件，当新的内容添加到文件后，它们会立即 出现在屏幕上。这会一直继续下去直到你输入 Ctrl-c

tee － 从 Stdin 读取数据，并同时输出到 Stdout 和文件

```shell
ls /usr/bin | tee ls.txt | grep zip
```


## 8.Shell

```shell
echo [[:upper:]]*

echo ~foo
/home/foo

echo ~
/home/me

echo $((2 + 2))
echo $(($((5**2)) * 3))
echo $(((5**2) * 3))
echo Five divided by two equals $((5/2))
```

##### 花括号展开 (注意空格)

```shell
echo Front-{A,B,C}-Back
=> Front-A-Back Front-B-Back Front-C-Back
echo Number_{1..5}
=> Number_1  Number_2  Number_3  Number_4  Number_5
echo a{A{1,2},B{3,4}}b
=> aA1b aA2b aB3b aB4b
```

创建批量的文件夹

```shell
 mkdir {2007..2009}-0{1..9} {2007..2009}-{10..12}
```

```shell
ls -l $(which cp)
ls -l `which cp`
 
file $(ls /usr/bin/* | grep zip)
```

##### 双引号

使用双引号，我们可以阻止单词分割

在双引号中，参数展开，算术表达式展开，和命令替换仍然有效

```shell
ls -l two words.txt
ls -l "two words.txt"
echo "$USER $((2+2)) $(cal)"
```

##### 单引号

如果需要禁止所有的展开，我们使用单引号

##### 转义字符

```shell
echo "The balance for user $USER is: \$5.00"
=> The balance for user me is: $5.00
```



## 9.键盘高级操作技巧

##### 移动光标

| Ctrl-a | 移动光标到行首。                       |
| ------ | ------------------------------ |
| Ctrl-e | 移动光标到行尾。                       |
| Ctrl-f | 光标前移一个字符；和右箭头作用一样。             |
| Ctrl-b | 光标后移一个字符；和左箭头作用一样。             |
| Alt-f  | 光标前移一个字。                       |
| Alt-b  | 光标后移一个字。                       |
| Ctrl-l | 清空屏幕，移动光标到左上角。clear 命令完成同样的工作。 |

##### 历史命令

| 按键     | 行为                                       |
| ------ | ---------------------------------------- |
| Ctrl-p | 移动到上一个历史条目。类似于上箭头按键。                     |
| Ctrl-n | 移动到下一个历史条目。类似于下箭头按键。                     |
| Alt-<  | 移动到历史列表开头。                               |
| Alt->  | 移动到历史列表结尾，即当前命令行。                        |
| Ctrl-r | 反向递增搜索。从当前命令行开始，向上递增搜索。                  |
| Alt-p  | 反向搜索，不是递增顺序。输入要查找的字符串，然后按下 Enter，执行搜索。   |
| Alt-n  | 向前搜索，非递增顺序。                              |
| Ctrl-o | 执行历史列表中的当前项，并移到下一个。如果你想要执行历史列表中一系列的命令，这很方便。 |

##### 历史命令展开

| 序列       | 行为                                  |
| -------- | ----------------------------------- |
| !!       | 重复最后一次执行的命令。可能按下上箭头按键和 enter 键更容易些。 |
| !number  | 重复历史列表中第 number 行的命令。               |
| !string  | 重复最近历史列表中，以这个字符串开头的命令。              |
| !?string | 重复最近历史列表中，包含这个字符串的命令。               |



## 10.权限

id 命令，来找到关于你自己身份的信息

用户帐户 定义在/etc/passwd 文件里面，用户组定义在/etc/group 文件里面，/etc/shadow 包含了关于用户密码的信息

```
-rw-rw-r--
文件类型，文件所有者，文件组所有者，和其他人的读,写,执行权限
- 普通文件
d 目录
l 符号链接
```

##### chmod － 更改文件模式

```shell
chmod 600 foo.txt
ls -l foo.txt
-rw------- 1 me    me    0  2008-03-06 14:52 foo.txt
```

符号表示法

| u+x       | 为文件所有者添加可执行权限。                           |
| --------- | ---------------------------------------- |
| u-x       | 删除文件所有者的可执行权限。                           |
| +x        | 为文件所有者，用户组，和其他所有人添加可执行权限。 等价于 a+x。       |
| o-rw      | 除了文件所有者和用户组，删除其他人的读权限和写权限。               |
| go=rw     | 给群组的主人和任意文件拥有者的人读写权限。如果群组的主人或全局之前已经有了执行的权限，他们将被移除。 |
| u+x,go=rw | 给文件拥有者执行权限并给组和其他人读和执行的权限。多种设定可以用逗号分开。    |

o:other u:self g:group

r:read w:write x:执行

##### umask － 设置默认权限

```
umask 0022
```

| Original file mode | --- rw- rw- rw- |
| ------------------ | --------------- |
| Mask               | 000 000 010 010 |
| Result             | --- rw- r-- r-- |

##### 更改身份

su － 以其他用户身份和组 ID 运行一个 shell

```shell
su -c 'command'
su -c 'ls -l /root/*'
```

使用这种模式，命令传递到一个新 shell 中执行



sudo － 以另一个用户身份执行命令

su 和 sudo 之间的一个重要区别是 sudo 不会重新启动一个 shell，也不会加载另一个 用户的 shell 运行环境



##### chown － 更改文件所有者和用户组

| 参数        | 结果                                       |
| --------- | ---------------------------------------- |
| bob       | 把文件所有者从当前属主更改为用户 bob。                    |
| bob:users | 把文件所有者改为用户 bob，文件用户组改为用户组 users。         |
| :admins   | 把文件用户组改为组 admins，文件所有者不变。                |
| bob:      | 文件所有者改为用户 bob，文件用户组改为，用户 bob 登录系统时，所属的用户组。 |

##### chgrp － 更改用户组所有权

##### 更改用户密码

```shell
passwd [user]
```



## 11.进程

进程状态

| 状态   | 意义                                       |
| ---- | ---------------------------------------- |
| R    | 运行。这意味着，进程正在运行或准备运行。                     |
| S    | 正在睡眠。 进程没有运行，而是，正在等待一个事件， 比如说，一个按键或者网络数据包。 |
| D    | 不可中断睡眠。进程正在等待 I/O，比方说，一个磁盘驱动器的 I/O。      |
| T    | 已停止. 已经指示进程停止运行。稍后介绍更多。                  |
| Z    | 一个死进程或“僵尸”进程。这是一个已经终止的子进程，但是它的父进程还没有清空它。 （父进程没有把子进程从进程表中删除） |
| <    | 一个高优先级进程。这可能会授予一个进程更多重要的资源，给它更多的 CPU 时间。 进程的这种属性叫做 niceness。具有高优先级的进程据说是不好的（less nice）， 因为它占用了比较多的 CPU 时间，这样就给其它进程留下很少时间。 |
| N    | 低优先级进程。 一个低优先级进程（一个“好”进程）只有当其它高优先级进程执行之后，才会得到处理器时间。 |

| 标题    | 意思                       |
| ----- | ------------------------ |
| USER  | 用户 ID. 进程的所有者。           |
| %CPU  | 以百分比表示的 CPU 使用率          |
| %MEM  | 以百分比表示的内存使用率             |
| VSZ   | 虚拟内存大小                   |
| RSS   | 进程占用的物理内存的大小，以千字节为单位。    |
| START | 进程运行的起始时间。若超过24小时，则用天表示。 |

ps aux

top

执行 jobs,可以列出从终端中启动的任务。

通过kill命令向进程发送信号

```shell
killall xlogo #杀死所有xlog进程
```



## 软件包管理

查找已经安装过的某个软件vim

```
aptitude search ~i | grep vim
dpkg-query -l | grep vim
dpkg-query -l | grep '^ii.*v.m'
```

检索所需要的软件包

```
aptitude search vim
```



# 存储媒介

/etc/fstab 的文件可以列出系统启动时要挂载的设备（典型地，硬盘分区）

```shell
LABEL=/12               /               ext3        defaults        1   1
LABEL=/home             /home           ext3        defaults        1   2
LABEL=/boot             /boot           ext3        defaults        1   2
```

| 字段   | 内容     | 说明                                       |
| ---- | ------ | ---------------------------------------- |
| 1    | 设备名    | 传统上，这个字段包含与物理设备相关联的设备文件的实际名字，比如说/dev/hda1（第一个 IDE 通道上第一个主设备分区）。然而今天的计算机，有很多热插拔设备（像 USB 驱动设备），许多 现代的 Linux 发行版用一个文本标签和设备相关联。当这个设备连接到系统中时， 这个标签（当储存媒介格式化时，这个标签会被添加到存储媒介中）会被操作系统读取。 那样的话，不管赋给实际物理设备哪个设备文件，这个设备仍然能被系统正确地识别。 |
| 2    | 挂载点    | 设备所连接到的文件系统树的目录。                         |
| 3    | 文件系统类型 | Linux 允许挂载许多文件系统类型。大多数本地的 Linux 文件系统是 ext3， 但是也支持很多其它的，比方说 FAT16 (msdos), FAT32 (vfat)，NTFS (ntfs)，CD-ROM (iso9660)，等等。 |
| 4    | 选项     | 文件系统可以通过各种各样的选项来挂载。有可能，例如，挂载只读的文件系统， 或者挂载阻止执行任何程序的文件系统（一个有用的安全特性，避免删除媒介。） |
| 5    | 频率     | 一位数字，指定是否和在什么时间用 dump 命令来备份一个文件系统。       |
| 6    | 次序     | 一位数字，指定 fsck 命令按照什么次序来检查文件系统。            |

##### 查看挂载的文件系统列表(mount)

```shell
当有插入光盘时，通过mount可以观察到新增加了
/dev/hdc on /media/live-1.0.10-8 type iso9660 (ro,noexec,nosuid,nodev,uid=500)

mkdir /mnt/cdrom  #创建挂载点
mount -t iso9660 /dev/hdc /mnt/cdrom   #-t 选项用来指定文件系统类型
卸载该设备，必须确保没有用户或进程在使用该设备，工作路径也不能再/mnt/cdrom下，否则会导致设备忙碌
umount /dev/hdc
```



## 网络系统

#### 检查和监测网络

ping 命令发送一个特殊的网络数据包，叫做 IMCP ECHO_REQUEST，并且会持续在特定的时间间隔内（默认是一秒）发送数据包，直到它被中断。

大多数网络设备（包括 Linux 主机）都可以被配置为忽略这些数据包， 出于网络安全 原因，部分地遮蔽一台主机免受一个潜在攻击者地侵袭。

##### traceroute - 打印到一台网络主机的路由数据包

看一下到达 slashdot.org 网站，需要经过的路由 器

```shell
traceroute slashdot.org
```

##### netstat - 打印网络连接，路由表，接口统计数据，伪装连接，和多路广播成员

“-ie”选项，能够查看系统中的网络接口, 等同于ifconfig

“-r”选项会显示内核的网络路由表 route

## 查找文件

```
find ~ -type f -name '*.csv'
find ~ -type f -name \*.csv
```

当前目录有多少文件

```shell
 find ~ -type d | wc -l
```

找大于1M的文件

```shell
find ~ -type f -size +1M | wc -l
find ~ -type f -name \*.* -size +1M | wc -l
```

```
find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \) | wc -l
```

```shell
find ~ \( -type f -mtime 6 \) -exec ls -ll '{}' ';'
find ~ \( -type f -mtime 6 \) | xargs ls -ll
```

找到比bad.txt更新的文件

```
find ~ \( -type f -mtime 6 -newer /home/deploy/bad.txt \)
```



```shell
ls -l /etc | gzip > foo.txt.gz
mkdir -p playground/dir-{00{1..9},0{10..99},100}
touch playground/dir-{00{1..9},0{10..99},100}/file-{A..Z}

find playground -name 'file-A' | tar cf - --files-from=- | gzip > playground.tgz
find playground -name 'file-A' | tar czf playground.tgz -T -

ls | vim -
ls | xargs vim

du -ah ~ | sort -n -r | head -n 10
find ~ -printf '%s %p\n'| sort -nr | head -10 | xargs ls -sh
```



```shell
for i in {1..10}; do echo "(${RANDOM:0:3}) ${RANDOM:0:3}-${RANDOM:0:4}" >> phonelist.txt; done
```

```
find . -name \*.txt | xargs du -h | sort | head -n 5
```



## 格式化输出

##### nl - 添加行号

```shell
nl distros.txt | head   #默认是非空行
等同于
nl -b t distros.txt | head # a = 数所有行， n = 无
nl -w 3 -s ' '  xxx.txt
nl -n rz xxx.txt
```

##### fold - 限制文件行宽

```shell
echo "The quick brown fox jumped over the lazy dog." | fold -w 12
# -s 选项将让 fold 分解到最后可用的空白 字符，即会考虑单词边界, 单词边界不会被分解
echo "The quick brown fox jumped over the lazy dog." | fold -w 12 -s
```

#### fmt - 一个简单的文本格式器

fmt 程序同样折叠文本，外加很多功能。它接受文本或标准输入并且在文本流上呈现照片转换。基础来说，他填补并且将文本粘帖在 一起并且保留了空白符和缩进。



ls -l ~/ken_lab | sort --key 5nr

diff -Naur old.txt new.txt > patch.txt

cat patch.txt

echo "aaaaaabbbbbbbbbbbbcabababababcabc" | sed 's/b\{4\}/BA/g'



## Shell脚本

把一个文件名从 myfile 改为 myfile1

```shell
filename="myfile"
touch $filename
mv $filename ${filename}1   #通过添加花括号，shell 不再把末尾的1解释为变量名的一部分
```

```shell
#!/bin/bash
# Program to output a system information page
TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME=$(date +"%x %r %Z")
TIME_STAMP="Generated $CURRENT_TIME, by $USER"
echo "<HTML>
        <HEAD>
                <TITLE>$TITLE</TITLE>
        </HEAD>
        <BODY>
                <H1>$TITLE</H1>
                <P>$TIME_STAMP</P>
        </BODY>
</HTML>"
```

#### Here Documents

```shell
#!/bin/bash
# Program to output a system information page
TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME=$(date +"%x %r %Z")
TIME_STAMP="Generated $CURRENT_TIME, by $USER"
cat << _EOF_
<HTML>
         <HEAD>
                <TITLE>$TITLE</TITLE>
         </HEAD>
         <BODY>
                <H1>$TITLE</H1>
                <P>$TIME_STAMP</P>
         </BODY>
</HTML>
_EOF_
```

字符串_EOF_（意思是“文件结尾”， 一个常见用法）被选作为 token，并标志着嵌入文本的结尾。注意这个 token 必须在一行中单独出现，并且文本行中 没有末尾的空格。

here document 很大程度上和 echo 一样，除了默认情况下，here documents 中的单引号和双引号会失去它们在 shell 中的特殊含义。

如果我们把重定向操作符从 “<<” 改为 “<<-”，shell 会忽略在此 here document 中开头的 tab 字符。 这就能缩进一个 here document，从而提高脚本的可读性

```shell
[me@linuxbox ~]$ foo="some text"
[me@linuxbox ~]$ cat << _EOF_
> $foo
> "$foo"
> '$foo'
> \$foo
> _EOF_
some text
"some text"
'some text'
```

```shell
#!/bin/bash
# Program to output a system information page
TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME=$(date +"%x %r %Z")
TIME_STAMP="Generated $CURRENT_TIME, by $USER"
report_uptime () {
  cat <<- _EOF_
  <H2>System Uptime</H2>
  <PRE>$(uptime)</PRE>
_EOF_     #结束标识前不能有空格
  return
}
report_disk_space () {
  cat <<- _EOF_
  <H2>Disk Space Utilization</H2>
  <PRE>$(df -h)</PRE>
_EOF_
  return
}
report_home_space () {
  cat <<- _EOF_
  <H2>Home Space Utilization</H2>
  <PRE>$(du -sh /home/*)</PRE>
_EOF_
  return
}
cat << _EOF_
<HTML>
    <HEAD>
        <TITLE>$TITLE</TITLE>
    </HEAD>
    <BODY>
        <H1>$TITLE</H1>
        <P>$TIME_STAMP</P>
        $(report_uptime)
        $(report_disk_space)
        $(report_home_space)
    </BODY>
</HTML>
_EOF_
```



## 第33章 位置参数

```shell
#!/bin/bash
# posit-param: script to view command line parameters
echo "
Number of arguments: $#
\$0 = $0
\$1 = $1
\$2 = $2
\$3 = $3
\$4 = $4
\$5 = $5
\$6 = $6
\$7 = $7
\$8 = $8
\$9 = $9
"
```

位置参数 $0 总会包含命令行中出现的第一个单词，也就是已执行程序的路径名

 $# 可以得到命令行参数个数的变量

```shell
bash posit-param a b c d
=>
Number of arguments: 4
$0 = /home/me/bin/posit-param
$1 = a
$2 = b
$3 = c
$4 = d
$5 =
$6 =
$7 =
$8 =
$9 =

bash posit-param *
# 通配符*会展开多个参数(当前路径下的文件)
=>
Number of arguments: 8
$0 = posit-param
$1 = TLCL.md
$2 = brew.md
$3 = command
$4 = elk.md
$5 = graylog.md
$6 = jenkins.md
$7 = posit-param
$8 = sys_info_page
$9 =
```

**shift 命令**， 就会导致所有的位置参数 “向下移动一个位置”

```shell
#!/bin/bash
# posit-param2: script to display all arguments
count=1
while [[ $# -gt 0 ]]; do
    echo "Argument $count = $1"
    count=$((count + 1))
    shift
done
```

```shell
echo $1

file_info () {
  # file_info: function to display file information
  if [[ -e $1 ]]; then
      echo -e "\nFile Type:"
      file $1
      echo -e "\nFile Status:"
      stat $1
  else
      echo "$FUNCNAME: usage: $FUNCNAME file" >&2
      return 1
  fi
}

echo "call file_info function:"
file_info "graylog.md";
```

| 参数   | 描述                                       |
| ---- | ---------------------------------------- |
| $*   | 展开成一个从1开始的位置参数列表。当它被用双引号引起来的时候，展开成一个由双引号引起来 的字符串，包含了所有的位置参数，每个位置参数由 shell 变量 IFS 的第一个字符（默认为一个空格）分隔开。 |
| $@   | 展开成一个从1开始的位置参数列表。当它被用双引号引起来的时候， 它把每一个位置参数展开成一个由双引号引起来的分开的字符串。 |

$*   => $1 $2 $3...

"$*"  => "$1 $2 $3"

$@  => $1 $2 $3

"$@"  => "$1" "$2" "$3"

```shell
#!/bin/bash
# posit-params3 : script to demonstrate $* and $@
print_params () {
    echo "\$1 = $1"
    echo "\$2 = $2"
    echo "\$3 = $3"
    echo "\$4 = $4"
}
pass_params () {
    echo -e "\n" '$* :';      print_params   $*
    echo -e "\n" '"$*" :';    print_params   "$*"    # "word words with spaces"
    echo -e "\n" '$@ :';      print_params   $@
    echo -e "\n" '"$@" :';    print_params   "$@"    # "word" "words with spaces"
}
pass_params "word" "words with spaces"
```



## 第34章 流程控制：for 循环

```shell
for i in A B C D; do echo $i; done
#花括号展开
for i in {A..D}; do echo $i; done
#路径名展开
for i in distros*.txt; do echo $i; done
```

```shell
#命令替换
#!/bin/bash
# longest-word : find longest string in a file
while [[ -n $1 ]]; do    #字符串不为null，长度大于零
    if [[ -r $1 ]]; then  #文件可读
        max_word=
        max_len=0
        for i in $(strings $1); do  #将文件的内容产生一个可读的文本格式的 “words” 列表
            len=$(echo $i | wc -c)
            if (( len > max_len )); then
                max_len=$len
                max_word=$i
            fi
        done
        echo "$1: '$max_word' ($max_len characters)"
    fi
    shift
done

或者
#!/bin/bash
# longest-word2 : find longest string in a file
for i; do
    if [[ -r $i ]]; then
        max_word=
        max_len=0
        for j in $(strings $i); do
            len=$(echo $j | wc -c)       #使用参数展开  ${#j}
            if (( len > max_len )); then
                max_len=$len
                max_word=$j
            fi
        done
        echo "$i: '$max_word' ($max_len characters)"
    fi
done
```

```shell
#C 语言格式
#!/bin/bash
# simple_counter : demo of C style for command
for (( i=0; i<5; i=i+1 )); do
    echo $i
done
```



## 第35章 字符串和数字

#### 参数展开

$a  ==> ${a}

```
echo "${a}_file"
```

位置参数 ${11}

##### ${parameter:-word}

若 parameter 没有设置（例如，不存在）或者为空，展开结果是 word 的值。若 parameter 不为空，则展开结果是 parameter 的值。

##### *${parameter:=word}*

若 parameter 没有设置或为空，展开结果是 word 的值。另外，word 的值会**赋值**给 parameter。 若 parameter 不为空，展开结果是 parameter 的值。

##### ${parameter:?word}

若 parameter 没有设置或为空，这种展开导致脚本**带有错误退出**，并且 word 的内容会发送到标准错误。若 parameter 不为空， 展开结果是 parameter 的值。

##### ${parameter:+word}

若 parameter 没有设置或为空，展开结果为空。若 parameter 不为空， 展开结果是 word 的值会**替换掉 **parameter 的值；然而，parameter 的值不会改变。

#### 返回变量名的参数展开

${#parameter}

展开成由 parameter 所包含的字符串的长度

*${parameter:offset}*

*${parameter:offset:length}*

这些展开用来从 parameter 所包含的字符串中提取一部分字符

```shell
[me@linuxbox ~]$ foo="This string is long."
[me@linuxbox ~]$ echo ${foo:5}
string is long.
[me@linuxbox ~]$ echo ${foo:5:6}
string
```

*${parameter#pattern}*

*${parameter##pattern}*

这些展开会从 paramter 所包含的字符串中清除开头一部分文本

```shell
[me@linuxbox ~]$ foo=file.txt.zip
[me@linuxbox ~]$ echo ${foo#*.}
txt.zip
[me@linuxbox ~]$ echo ${foo##*.}
zip
```

*${parameter%pattern}*

*${parameter%%pattern}*

这些展开和上面的 # 和 ## 展开一样，除了它们清除的文本从 parameter 所包含字符串的末尾开始，而不是开头。

*${parameter/pattern/string}*

*${parameter//pattern/string}*

*${parameter/#pattern/string}*

*${parameter/%pattern/string}*

```shell
[me@linuxbox~]$ foo=JPG.JPG
[me@linuxbox ~]$ echo ${foo/JPG/jpg}    #替换第一个
jpg.JPG
[me@linuxbox~]$ echo ${foo//JPG/jpg}    #替换全部
jpg.jpg
[me@linuxbox~]$ echo ${foo/#JPG/jpg}    #从开头开始匹配
jpg.JPG
[me@linuxbox~]$ echo ${foo/%JPG/jpg}    #从末尾开始匹配
JPG.jpg
```

使用参数展开效率更高

#### 大小写转换

使用 declare 命令，我们能强制一个 变量总是包含所需的格式，无论如何赋值给它。

```shell
#!/bin/bash
# ul-declare: demonstrate case conversion via declare
declare -u upper
declare -l lower
if [[ $1 ]]; then
    upper="$1"
    lower="$1"
    echo $upper
    echo $lower
fi
```

大小写转换参数展开

| 格式             | 结果                                  |
| -------------- | ----------------------------------- |
| ${parameter,,} | 把 parameter 的值全部展开成小写字母。            |
| ${parameter,}  | 仅仅把 parameter 的第一个字符展开成小写字母。        |
| ${parameter^^} | 把 parameter 的值全部转换成大写字母。            |
| ${parameter^}  | 仅仅把 parameter 的第一个字符转换成大写字母（首字母大写）。 |

```shell
#!/bin/bash
# ul-param - demonstrate case conversion via parameter expansion
if [[ $1 ]]; then
    echo ${1,,}
    echo ${1,}
    echo ${1^^}
    echo ${1^}
fi
```

#### 算术求值和展开

```shell
$((expression))
```

数基

| 表示法         | 描述                               |
| ----------- | -------------------------------- |
| number      | 默认情况下，没有任何表示法的数字被看做是十进制数（以10为底）。 |
| 0number     | 在算术表达式中，以零开头的数字被认为是八进制数。         |
| 0xnumber    | 十六进制表示法                          |
| base#number | number 以 base 为底                 |

```shell
#!/bin/bash
# modulo : demonstrate the modulo operator
for ((i = 0; i <= 20; i = i + 1)); do
    remainder=$((i % 5))
    if (( remainder == 0 )); then
        printf "<%d> " $i
    else
        printf "%d " $i
    fi
done
printf "\n"
```

##### 赋值运算符

```shell
[me@linuxbox ~]$ foo=
[me@linuxbox ~]$ echo $foo
[me@linuxbox ~]$ if (( foo = 5 ));then echo "It is true."; fi
It is true.
[me@linuxbox ~]$ echo $foo
5
```

首先我们给变量 foo 赋了一个空值，然后验证 foo 的确为空。下一步，我们执行一个 if 复合命令 (( foo = 5 ))。 这个过程完成两件有意思的事情：1）它把5赋值给变量 foo，2）它计算测试条件为真，因为 foo 的值非零。



