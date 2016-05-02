### 达到对应的数据库
```
show dbs
use dbname
show collections
```

### 简单查询
```
db.users.find({email: "admin@dc.gov" })  # 返回符合条件的所有记录
db.users.find({email: /admin/})          # 正则
db.users.findOne({})                     # 返回一条记录

#  指定哪些字段显示(1)，哪些字段隐藏(0), 只显示email
db.users.find({name: /jack/}, {name: 1, _id: 0})
db.users.find(:name => {:$exists => true}).projection({:_id => false})
```

#### 比较查询
```
# 查询年龄在一个区间(18~30)的user
db.users.find({age: {"$gte" : 18, "$lte" : 22}})
# 不等于
db.users.find({name: {"$ne" : "jack"}})
```

#### 关联查询
```
# $in 用于查询一个键的多个值, 满足array中的一个即可
db.users.find({name: {$in: ["jack", "York"]}})

# 数组中满足一个就行
db.users.find({likes: {$in: ["ruby", "mongodb"]}})

# $or 用于对多个键做or查询, 只要满足一个条件
db.users.find({$or: [{name: "jack"}, {age: 30}]})

# $and 用于对多个键做and查询, 要满足所有的查询条件
db.users.find({$and: [{name: "jack"}, {age: 20}]})
```

### 取模运算$mod
```
# 年龄是10的倍数
db.users.find( "this.age % 10 == 0")
# 可用$mod代替：
db.users.find({age: {$mod: [10, 0]}})
```

### For Array
##### in or all
```
# 需要匹配array条件内所有的值
{ likes: [ "rails", "mongodb" ] }
db.users.find({likes: {$all: ["rails", "mongodb"]}});            #找得到
db.users.find({likes: {$all: ["rails", "mongodb", "ruby"]}});    #找不到 
```

查询数组中的对应字段(下标从0开始)
```
db.food.find({"fruit.2" : "peach"})  ===>  {"fruit" : ["banana", "apple", "peach"]}
```

##### size
查询指定长度的数组
```
db.users.find({likes: {"$size" : 2}})
```

##### slice
返回数组的一个子集合
```
db.blog.posts.findOne(criteria, {"comments" : {"$slice" : 10}})    # comment中的前10条
db.blog.posts.findOne(criteria, {"comments" : {"$slice" : [23, 10]}})   # comment中的24～33条 
db.people.findOne({}, {addresses: {$slice:1}})
```

### For Embedded Documents
```
db.people.find({"name" : {"first" : "Joe", "last" : "Schmoe"}})
or
db.people.find({"name.first" : "Joe", "name.last" : "Schmoe"})
```

```
db.stock.find({"desc" : "mp3"}).limit(50).skip(50).sort({"price" : -1})
```


##### 参考:
* http://www.tuicool.com/articles/BvI7ru
