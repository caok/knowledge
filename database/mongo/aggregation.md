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

db.plans.aggregate({$project: {active_year: 1}}, {$group: {_id: "$active_year", count: {$sum: 1}}}, {$sort: {count: -1}})
```

project 中重命名(将_id重命名为userId, 并且将_id不显示出来)
```
db.users.aggregate({"$project" : {"userId" : "$_id", "_id" : 0}})
db.people.aggregate({$project: {age: {$subtract: [{$year: new date()}, {$year: "$dob"}]}}})
```

##### Group
```
db.plans.aggregate({$group: {_id: "$active_year"}})
db.plans.aggregate({$group: {_id: "$active_year", "num":{$sum: 1}}})   #统计每个active_year有多少个
db.plans.aggregate({$group: {_id: {"year": "$active_year", "kind": "$metal_level"}}})
db.plans.aggregate({$group: {_id: "$active_year", "maxage":{$max: "$maximum_age"}}})
```

##### $unwind
```
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
map = function() { emit(this.active_year, {count: 1}); }

reduce = function(key, values) {
  total = 0;

  values.forEach(function(value) {
    total += value.count; 
  });
  return {"count" : total};
}

mr = db.runCommand({"mapreduce": "plans", "map": map, "reduce": reduce, "out": "result"})
db[mr.result].find()
db.result.find();
```

##### Aggregation Command
```
db.plans.count()
db.plans.count({active_year: 2014})

db.runCommand({"distinct" : "plans", "key" : "active_year"})
```

```
results = db.plans.group({
  key:      {"active_year": true},
  initial:  {num: 0, ehbs: 0.0},
  reduce:   function(doc, agg) {
               agg.num += 1;
               agg.ehbs += doc.ehb;
            },
  finalize: function(doc) {doc.average_ehb = doc.ehbs / doc.num;}
}) 

```
