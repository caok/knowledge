```
file 'config/database.yml' => 'config/database.yml.example' do |task|
  cp task.prerequisites.first, task.name
end

rule '.yml' => '.yml.example' do |task|
  cp task.source, task.name
end

#rake config/database.yml
```

```
rule /foo/ do |task|
  puts 'called task named: %s' % task.name
end

# $ rake foobar
# called task named: foobar
```

```
rule /\.txt$/ do |task|
  puts 'creating file: %s' % task.name
  touch task.name
end

rule '.txt' do |task|
  puts 'creating file: %s' % task.name
  touch task.name
end
```

### Dependencies
```
rule '.dependency' do |task|
  puts 'called task: %s' % task.name
end

rule '.task' => '.dependency' do |task|
  puts 'called task: %s' % task.name
end

# $ rake rule.task
# called task: rule.dependency
# called task: rule.task
```

### rule for files
```
rule '.txt' => '.template' do |task|
  cp task.prerequisites.first, task.name
end

rule '.txt' => '.template' do |task|
  cp task.source, task.name
end
```



参考:
* http://blog.csdn.net/vagrxie/article/details/8861285
* http://madewithenvy.com/ecosystem/articles/2014/rake-rule-tasks/
