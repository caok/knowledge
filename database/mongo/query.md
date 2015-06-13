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
db.users.find({email: /admin/}, {email: 1, _id: 0})
```

#### 比较查询
```
# 查询年龄在一个区间(18~30)的user
db.users.find({age: {"$gte" : 18, "$lte" : 30}})
# 不等于
db.users.find({email: {"$ne" : "admin@dc.gov"}})
```

#### 关联查询
```
# $in 用于查询一个键的多个值, 满足array中的一个即可
db.people.find({last_name: {$in: ["White", "York"]}})

# $or 用于对多个键做or查询, 只要满足一个条件
db.people.find({$or: [{last_name: "White"}, {hbx_id: "234112"}]})

# $and 用于对多个键做and查询, 要满足所有的查询条件
db.people.find({$and: [{last_name: "White"}, {hbx_id: "234112"}]})
```

### 取模运算$mod
```
db.things.find( "this.a % 10 == 1")
# 可用$mod代替：
db.things.find( { a : { $mod : [ 10 , 1 ] } } )
```

### For Array
##### in or all
```
# 需要匹配array条件内所有的值
{ a: [ 1, 2, 3 ] }
db.things.find( { a: { $all: [ 2, 3 ] } } );       #找得到
db.things.find( { a: { $all: [ 2, 3, 4 ] } } );    #找不到 
```

查询数组中的对应字段(下标从0开始)
```
db.food.find({"fruit.2" : "peach"})  ===>  {"fruit" : ["banana", "apple", "peach"]}
```

##### size
查询指定长度的数组
```
db.food.find({"fruit" : {"$size" : 3}})
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
