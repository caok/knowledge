### File
```
file 'foo.txt' do
  touch 'foo.txt'
end

# rake foo.txt
```
FileUtils.touch works like the Unix touch program: updates a file’s timestamps and creates nonexistent files.
当foo.txt不存在时才会touch一个出来

```
file 'foo.txt' => 'bar.txt' do
  touch 'foo.txt'
end
```
这里的‘bar.txt’相当于一个先决条件, 要求存在bar.txt,在bar.txt存在的基础上决定是否执行foo.txt,
这里也会判断bar.txt的时间戳，如果时间戳变了，foo.txt也会重新再执行
```
file 'bar.txt' do
end

file 'foo.txt' => 'bar.txt' do
  touch 'foo.txt'
end
```

```
file 'config/database.yml' => 'config/database.yml.example' do
  cp 'config/database.yml.example', 'config/database.yml'
end

file 'config/database.yml' => 'config/database.yml.example' do |task|
  cp task.prerequisites.first, task.name
end
```



参考:
* http://madewithenvy.com/ecosystem/articles/2013/rake-file-tasks/
