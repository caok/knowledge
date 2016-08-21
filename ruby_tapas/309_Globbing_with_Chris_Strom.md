```
# bash下
# 列出当前文件夹下以p开头的文件
# -1 一个条目一行
# -d 不会去递归的查询
ls -1 p*
ls -1d [abc]*
ls -1d *.rb
ls -1 code-js/svg/elements/*.{js,html}
ls -1 **/*.{js,html}
ls -1 ./**/*.{rb,html} | wc -l
ls -1 */!(node_modules|bower_componetns|packages|play)/*.{js,html}
ls -1 ./!(shared|welcome)/*.erb
```

```
http://man.linuxde.net/shopt
shopt命令用于显示和设置shell中的行为选项，通过这些选项以增强shell易用性。shopt命令若不带任何参数选项，则可以显示所有可以设置的shell操作选项。 
语法
shopt(选项)(参数) 

选项
-s：激活指定的shell行为选项；
-u：关闭指定的shell行为选项。
```

```
$ irb
irb(main):001:0> RUBY_VERSION
=> "2.2.3"
irb(main):002:0> Dir['*/*.erb']
Dir['./*/*.{erb,haml}']
Dir['[abc]*']

Dir['./!(shared|welcome)/*.erb'] 不起效果
Dir['./*/*.erb'].reject {|p| /(shared|welcome)/.match(p) }

Dir['**/*.rb'].each{|lib| require_relative lib}
```
