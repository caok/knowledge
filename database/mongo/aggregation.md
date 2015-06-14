### Aggregation

* $project：包含、排除、重命名和显示字段
* $match：查询，需要同find()一样的参数
* $limit：限制结果数量
* $skip：忽略结果的数量
* $sort：按照给定的字段排序结果
* $group：按照给定表达式组合结果
* $unwind：分割嵌入数组到自己顶层文件

```
db.articles.aggregate({"$project" : {"author" : 1}}, {"$group" : {"_id" : "$author", "count" : {"$sum" : 1}}}, {"$sort" : {"count" : -1}}, {"$limit" : 5})

db.users.aggregate({$project: {age: 1}}, {$group: {_id: "$age", count: {$sum: 1}}}, {$sort: {count: -1}})
```

project 中重命名(将_id重命名为userId, 并且将_id不显示出来)
```
db.users.aggregate({"$project" : {"userId" : "$_id", "_id" : 0}})
db.people.aggregate({$project: {age: {$subtract: [{$year: new date()}, {$year: "$dob"}]}}})
```

##### Group
```
db.users.aggregate({$group: {_id: "$age"}})
db.users.aggregate({$group: {_id: "$age", "num":{$sum: 1}}})   #统计每个age有多少个

db.posts.aggregate({$group: {_id: "$category", "num":{$sum: 1}}})    # 每个类别的文章有几篇
db.posts.aggregate({$group: {_id: {category: "$category", author: "$author"}, "num":{$sum: 1}}})   #每个作者每个类别分别有几篇文章
db.posts.aggregate({$group: {_id: "$author", "maxscore": {$max: "$score"}}})   #每个作者获得的最高分
```

##### $unwind
```
db.posts.aggregate({"$unwind" : "$comments"})  #如果一篇post中有两个comment，那么查询结果就会返回两条


db.blog.findOne()
{
  "_id" : ObjectId("50eeffc4c82a5271290530be"),
  "author" : "k",
  "post" : "Hello, world!",
  "comments" : [
    {
      "author" : "mark",
      "date" : ISODate("2013-01-10T17:52:04.148Z"),
      "text" : "Nice post"
  }, {
  ...
  } ]
}

> db.blog.aggregate({"$unwind" : "$comments"})
{
  "results" : [{
                "_id" : ObjectId("50eeffc4c82a5271290530be"),
                "author" : "k",
                "post" : "Hello, world!",
                "comments" : {
                    "author" : "mark",
                    "date" : ISODate("2013-01-10T17:52:04.148Z"),
                    "text" : "Nice post"
          } }, {
                "_id" : ObjectId("50eeffc4c82a5271290530be"),
                "author" : "k",
                "post" : "Hello, world!",
                "comments" : {
                    "author" : "bill",
                    "date" : ISODate("2013-01-10T17:52:04.148Z"),
                    "text" : "I agree"
          } }
], "ok" : 1 }
```

##### Map-reduce
```
map = function() { emit(this.category, {count: 1}); }

reduce = function(key, values) {
  total = 0;

  values.forEach(function(value) {
    total += value.count; 
  });
  return {"count" : total};
}

mr = db.runCommand({"mapreduce": "posts", "map": map, "reduce": reduce, "out": "result"})
db[mr.result].find()
db.result.find();
```

##### Aggregation Command
```
db.posts.count()
db.posts.count({category: "ruby"})

db.runCommand({"distinct" : "posts", "key" : "category"})
```

```
results = db.posts.group({
  key:      {"author": true},
  initial:  {num: 0, scores: 0.0},
  reduce:   function(doc, agg) {
               agg.num += 1;
               agg.scores += doc.score;
            },
  finalize: function(doc) {doc.average_score = doc.scores / doc.num;}
}) 

```
