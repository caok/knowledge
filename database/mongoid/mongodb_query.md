db.shelf.findOne({passion: {"$in": [ /Ruby/ ]}})
db.shelf.update({name:"Gautam Rege"}, {$set:{passion: ["Ruby"]}} )
db.shelf.findOne({$or: [{age: {$gt: 14}}, {name: /ege3/}, {passion: {$in: [/Raaby/]}}]})


### Group

results = db.reviews.group({
  key:      {user_id: true},
  initial:  {reviews: 0, votes: 0.0},
  reduce:   function(doc, aggregator) {
               aggregator.reviews += 1;
               aggregator.votes   += doc.votes;
            }
  finalize: function(doc) {
               doc.average_votes = doc.votes / doc.reviews;
            }
})

###### result:
[
  {user_id: ObjectId("4d00065860c53a481aeab608"),
   votes: 25.0,
   reviews: 7,
   average: 3.57
},
  {user_id: ObjectId("4d00065860c53a481aeab608"),
   votes: 25.0,
   reviews: 7,
   average: 3.57
} ]


### map-reduce
*  map—A JavaScript function to be applied to each document. This function must call emit() to select the keys and values to be aggregated. Within the function context, the value of this is a reference to the current document. So, for example, if you wanted to group your results by user ID and produce totals on a vote count and document count, then your map function would look like this:
```
function() {
  emit(this.user_id, {vote_sum: this.vote_count, doc_count: 1});
}
```
* key: user_id
* values: {vote_sum, doc_count}

* reduce—A JavaScript function that receives a key and a list of values. This function must always return a value having the same structure as each of the values provided in the values array. A reduce function typically iterates over the list of values and aggregates them in the process. Sticking to our example, here’s how you’d reduce the mapped values:
```
function(key, values) {
  var vote_sum = 0;
  var doc_sum  = 0;

  values.forEach(function(value) {
    vote_sum += value.vote_sum;
    doc_sum  += value.doc_sum;
  });
  return {vote_sum: vote_sum, doc_sum: doc_sum};
}
```
Note that the value of the key parameter frequently isn’t used in the aggregation itself.


原子操作
db.orders.findAndModify({
  query: {user_id: ObjectId("4c4b1476238d3b4dd5000001"),
          total: 99000,
          state: "PRE-AUTHORIZE" },
  update: {"$set": {"state": "AUTHORIZING"}}
})

