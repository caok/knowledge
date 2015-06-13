#### create
```
post = {"title": "My Blog Post", "date": new Date()}
db.blog.insert(post)
# 批量插入
db.foo.batchInsert([{"_id" : 0}, {"_id" : 1}, {"_id" : 2}])
```

#### read
```
db.blog.find()
db.blog.findOne({"name" : "joe"})
```

#### update
```
db.blog.update({title : "My Blog Post"}, post)
db.users.update({"_id" : ObjectId("4b253b067525f35f94b60a31")}, {"$set" : {"favorite book" : "War and Peace"}})
db.games.update({"game" : "pinball", "user" : "joe"},{"$inc" : {"score" : 50}})
往数组中增加 
db.blog.posts.update({"title" : "A blog post"}, {"$push" : {"comments" : {"name" : "bob", "email" : "bob@example.com","content" : "good post."}}})
从数组中删除
db.blog.posts.update({"title" : "A blog post"}, {"$pop" : {"key" : 1}})
```

#### delete
```
db.blog.remove({title : "My Blog Post"})
```

{"x" : NumberInt("3")}  ==> 4-byte
{"x" : NumberLong("3")} ==> 8-byte


```
ps = db.runCommand({"findAndModify" : "processes", "query" : {"status" : "READY"}, "sort" : {"priority" : -1}, "remove" : true}).value
do_something(ps)
```
