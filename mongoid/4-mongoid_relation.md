* One-to-One (1-1) relation
* One-to-Many (1-N) relation
* Many-to-Many (N-N) relation
* Polymorphic relation

## has_one

##### :as
多态时需要使用该选项

has_one :vehicle, as: resource

This tells the has_one method that the vehicle is a polymorphic relation that can be accessed via the **resource_type** and **resource_id** fields in the vehicles collection. It's important that the inverse relation sets polymorphic: true, and we will see polymorphic relations soon.

##### :autosave
当对象创建，相关联的child 对象也同样被创建，但更新时不会联动
当使用accepts_nested_attributes_for时， autosave会自动被加上

##### :autobuild


## has_many
##### order
```
has_many :books, order: {title: 1}
```
**ascending order**

##### support callback
```
has_many :books, after_add: :send_email
```

* :before_add
* :before_remove
* :after_add
* :after_remove

Model#{name}_ids: Get the related document ids.

比如
```
author.books
author.book_ids
```
但在embeds_many中没有该方法


# belongs_to
##### :polymorphic 与:as配合使用
```ruby
has_one :book, as: resource
belongs_to :author, polymorphic: true
```

##### :touch
当child改变了，parent自动调用update，更新updated_at

##### :counter_cache
如果设置了Mongoid:Attributes::Dynamic后，books_count会自动创建
```ruby
class Author
  field :books_count, type: Integer, default: 0
end

class Book
  belongs_to :author, counter_cache: :books_count
end
```

#### Recursive relationship
```ruby
class Author
  include Mongoid::Document

  has_and_belongs_to_many :followers, 
                          class_name: "Author",
                          inverse_of: :following

  has_and_belongs_to_many :following, 
           class_name: "Author",
           inverse_of: :followers

end
```
这类followers和following的关系被称为recursive relationships(递归关系)


## embeds_many
```
embeds_many :reviews, cascade_callbacks: true
```
当父类保存时embedded documents作为父类的一部分，他们的callback不会自动被触发，除非我们设置cascade_callbacks

**store_as** 改变embedded document的name
**cyclic** 用于 recursive relationship
```ruby
class Author
  include Mongoid::Document
  embeds_many :child_authors, class_name: "Author", cyclic: true
  embedded_in :parent_author, class_name: "Author", cyclic: true
end
```

## Recursive Embedding
以上可以简化写为 
```ruby
class Author
  include Mongoid::Document
  recursively_embeds_many
end
```
例子
```ruby
class Tag
  include Mongoid::Document
  recursively_embeds_many
end

root = Tag.new(name: "programming")
child_one = root.child_tags.build
child_two = root.child_tags.build

root.child_tags # [ child_one, child_two ]
child_one.parent_tag # [ root ]
child_two.parent_tag # [ root ]

class Node
  include Mongoid::Document
  recursively_embeds_one
end

root = Node.new
child = Node.new
root.child_node = child

root.child # child
child.parent_node # root
```


## Extensions
对embeds_many进行扩展

```ruby
class Person
  include Mongoid::Document
  embeds_many :addresses do
    def find_by_country(country)
      where(country: country).first
    end
    def chinese
      @target.select { |address| address.country == "China"}
    end
  end
end

person.addresses.find_by_country("Mongolia") # returns address
person.addresses.chinese # returns [ address ]
```

## Validations(validates_associated)
It is important to note that by default, Mongoid will validate the children of any relation that are loaded into memory via a **validates_associated**. The relations that this applies to are:

* embeds_many
* embeds_one
* has_many
* has_one
* has_and_belongs_to_many

关闭
```
has_many :posts, validate: false
```

## Existence Predicates
```ruby
class Band
  include Mongoid::Document
  embeds_one :label
  embeds_many :albums
end

band.label?
band.has_label?
band.albums?
band.has_albums?
```
