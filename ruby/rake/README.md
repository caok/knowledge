假设在周末你打算为你的家人做一些贡献。所以你为自己制定了三个任务：买菜、做饭和洗衣服。
Rake会在当前路径下寻找名叫Rakefile、rakefile、RakeFile.rb和rakefile.rb的rake文件


```
desc "任务1 -- 买菜"
task :buy do
  puts "到菜场去买菜。"
end

desc "任务2 -- 做饭"
task :cook do
  puts "做一顿香喷喷的饭菜。"
end

desc "任务3 -- 洗衣服"
task :laundry do
  puts "把所有衣服扔进洗衣机。"
end
```
rake -T
rake --tasks
rake buy

### 加入依赖关系
```
desc "任务1 -- 买菜"
task :buy do
  puts "到菜场去买菜。"
end

desc "任务2 -- 做饭"
task :cook => :buy do
  puts "做一顿香喷喷的饭菜。"
end

desc "任务3 -- 洗衣服"
task :laundry do
  puts "把所有衣服扔进洗衣机。"
end
```

### 命名空间
```
namespace :home do
  desc "任务1 -- 买菜"
  task :buy do
    puts "到菜场去买菜。"
  end
  
  desc "任务2 -- 做饭"
  task :cook => :buy do
    puts "做一顿香喷喷的饭菜。"
  end
  
  desc "任务3 -- 洗衣服"
  task :laundry do
    puts "把所有衣服扔进洗衣机。"
  end
end
```
rake home:buy

### 在一个任务中调用另外一个任务
```
desc "今天的任务"
task :today do
  Rake::Task["home:cook"].invoke
  Rake::Task["home:laundry"].invoke
end

namespace :home do
  ...
end
```

### 默认任务
```
task :default => [:today] 

desc "今天的任务"
task :today do
  Rake::Task["home:cook"].invoke
  Rake::Task["home:laundry"].invoke
end

namespace :home do
  desc "任务1 -- 买菜"
  task :buy do
    puts "到菜场去买菜。"
  end
  
  desc "任务2 -- 做饭"
  task :cook => :buy do
    puts "做一顿香喷喷的饭菜。"
  end
  
  desc "任务3 -- 洗衣服"
  task :laundry do
    puts "把所有衣服扔进洗衣机。"
  end
end
```

* https://github.com/ruby/rake
* http://madewithenvy.com/ecosystem/articles/2014/rake-rule-tasks/
