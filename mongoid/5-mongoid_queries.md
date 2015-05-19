[Mongoid Queries](http://mongoid.org/en/mongoid/docs/querying.html)

[Origin](https://github.com/mongoid/origin) is just an extraction of Mongoid's criteria into its own gem.

All queries in Mongoid are **Criteria**, which is a chainable and lazily evaluated wrapper to a MongoDB dynamic query. Criteria only touch the database when they need to, for example on iteration of the results, and when executed wrap a cursor in order to keep memory management and performance predictable.

Criteria 是一个中间对象, 保持按需查询以提高效率.

where 是延时查询

Relation或者 Scope的对象保存了我们希望进行的查询条件信息，但是数据库并没有实际执行这个查询操作。即除非真正使用这些数据，否则实际的查询就不进行，实际的数据库查询不会在controller调用的时候执行。而是，在view页面进行迭代输出的时候执行。

##Query
```
Book.in(awards: ["xxx"]).first
==>
Book.where(awards: "xxx").first
```


## Scope
```ruby
scope :latest, gte(published_data: Date.today.beginning_of_year)
scope :latest, -> { gte(published_data: Date.today.beginning_of_year) }

class Brand
  scope :named, ->(name){ where(name: name) }
  scope :active, where(active: true) do
    def deutsch
      tap |scope| do
        scope.selector.store("origin" => "Deutschland")
      end
    end
  end
end

Band.named("Depeche Mode")
Band.active.deutsch
```

#### default scope
```ruby
default_scope where(active: true)

Band.unscoped.where(name: "Depeche Mode")
Band.unscoped do
  Band.where(name: "Depeche Mode")
end
```
If you are using a default scope on a model that is part of a relation like a has_many, has_and_belongs_to_many, or embeds_many, you must reload the relation to have scoping reapplied. This is important to note if you change a value of a document in the relation that would affect its visibility within the scoped relation.
```ruby
class Label
  include Mongoid::Document
  embeds_many :bands
end

class Band
  include Mongoid::Document
  field :active, default: true
  embedded_in :label
  default_scoped where(active: true)
end

label.bands.push(band)
label.bands #=> [ band ]
band.update_attribute(:active, false)
label.bands #=> [ band ] Must reload.
label.reload.bands #=> []
```


## Atomic modifiers
```ruby
Job.where(status: false).find_and_modify('$set' => {status: true})
```

#### Covered queries
不真正查找数据库数据，只查找数据库中的索引
```ruby
Book.only(title: 1).where(title: /count/)
```
如果想检查的话，使用.explain


## Aggregation
count, max, min, sum, avg
```ruby
# Use map/reduce, return a float with the max value.
Band.where(:likes.gt => 100).max(:likes)

# Use enumerable, returning the document with the max value.
Band.where(:likes.gt => 100).max do |a,b|
  a.likes <=> b.likes
end
```
```
Author.collection.aggregate({ "$group" => { "_id" => "$name", count: { "$sum" => "$books_count" }}})
```

### Geo Near
[geoNear](http://mongoid.org/en/mongoid/docs/querying.html#geo_near)

