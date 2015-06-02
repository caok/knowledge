## [Indexes](http://mongoid.org/en/mongoid/docs/indexing.html)

rake -T db:mongoid

index({ ssn: 1 }, { unique: true, drop_dups: true })
小心使用drop_dups， 它会删除数据
index({ ssn: 1 }, { unique: true, background: true })
当创建时他不会立刻更新index， 它会在后台更新，是异步的

## Compound index

If you require consolidated numbers or grouping with no data manipulation, try to use the aggregation framework to get your results; if that is not feasible, use MapReduce.
