#How to Generate Weighted Random Numbers(http://www.blackbytes.info/2016/05/weighted-random-numbers/)
有权重的生成随机数
情景: 比如抽奖, 有更多门票的人，中奖的概率越大
For example, if John buys 4 raffle tickets and David only buys 1, John will have 4 times more chances to win than David.
```
users  = { john: 4, david: 1 }
raffle = []
 
users.map do |name, tickets|
  tickets.times { raffle << name }
end
 
p raffle
# [:john, :john, :john, :john, :david]
 
p raffle.sample
# :john
```

There is another way you can do this that is more memory-efficient, the trade-off is that picking a random value is slower.

The idea is to pick a random number between 1 and the sum of all the weights, and then loop until you find a weight that is lower or equal than this number.
```
def random_weighted(weighted)
  max    = sum_of_weights(weighted)
  target = rand(1..max)
 
  weighted.each do |item, weight|
    return item if target <= weight
    target -= weight
  end
end
 
def sum_of_weights(weighted)
  weighted.inject(0) { |sum, (item, weight)| sum + weight }
end
```
example
```
counts = Hash.new(0)
 
def pick_number
  random_weighted(cats: 2, dogs: 1)
end
 
1000.times { counts[pick_number] += 1 }
=> {:cats=>691, :dogs=>309}
```


#Rails 5 adds a way to get information about types of failed validations(5/3)
```
class User < ApplicationRecord
  validates :email, presence: true
end

>> user = User.new
>> user.valid?
=> false

#rails4
>> user.errors.messages
=> {:email=>["can't be blank"]}

#rails5
>> user.errors.details
=> {:email=>[{:error=>:blank}]}
```

```
# Custom validator type
>> user = User.new
>> user.errors.add(:name, :not_valid, message: "The name appears invalid")

>> user.errors.details
=> {:name=>[{:error=>:not_valid}]}

# Custom error with default validator type :invalid

>> user = User.new
>> user.errors.add(:name)

>> user.errors.details
=> {:name=>[{:error=>:invalid}]}

# More than one error on one attribute

>> user = User.new
>> user.errors.add(:password, :invalid_format, message: "Password must start with an alphabet")
>> user.errors.add(:password, :invalid_length, message: "Password must have atleast 8 characters")

>> user.errors.details
=> {:password=>[{:error=>:invalid_format}, {:error=>:invalid_length}]}
```
rails4中想要此类功能的话，可以使用gem: active_model-errors_details


#Rails 5 - What's in it for me?(4/22)
Major Features
Ruby 2.2.2+ dependency.
Action Cable.
API only apps.

Features for Development mode
Puma as default web server.
rails CLI over rake.
Restarting app using rails restart.
Enable caching using rails dev:cache.
Enhanced filtering of routes using rails routes -g
Evented file system monitor.

Features for Test mode
Test Runner.
Changes to controller tests.

Features related to Caching
Cache content forever using http_cache_forever.
Collection caching using ActiveRecord#cache_key.
Partials caching using multi_fetch_frgaments.
Caching in Action Mailer views.

Changes in Active Record
Introduction of ApplicationRecord.
ActiveRelation#or.
has_secure_token for generating secure tokens.
Versioned migrations for backward compatibility.

Changes in Active Support
Improvements to Date/Time.
Enumerable#pluck, Enumerable#without.
Change in behavior related to halting callback chains.

#Rails 5 officially supports MariaDB(4/21)
rails5官方开始支持MariaDB

--------------------------------------------------------------------------------------------
#Changes to test controllers in Rails 5(4/19)
```
#rails 4
class ProductsControllerTest < ActionController::TestCase
  def test_index_response
    get :index
    assert_response :success
  end
end
#rails 5, 用action会导致URI::InvalidURIError: bad URI
class ProductsControllerTest < ActionDispatch::IntegrationTest
  def test_index
    get products_url
    assert_response :success
  end
end
```
rails5 中移除了assert_template和assigns， 将其抽成了gem( rails-controller-testing)


#Parameter filtering enhancement in Rails 5(3/7)
rails5中将filter_parameters做了增强

rails4中
```
config.filter_parameters += [:code]

{credit_card: {number: "123456789", code: "999"}}
{user_preference: {color: {name: "Grey", code: "999999"}}}
```
此时credit_card和user_preference中的code在log中都会显示为“[FILTERED]”
但实际上我们只想对credit_card中的code做该处理，而user_preference中的code还是在log中正常显示
rails5中就对这种情况做了增强
```
config.filter_parameters += ["credit_card.code"]
```

#Rails 5 adds http_cache_forever to allow caching of response forever(3/4)
在处理一些静态页面的时候，rails原先的出来需要一遍一遍的去render

```
# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    http_cache_forever(public: true) {}
  end
end

# OR
class HomeController < ApplicationController
  def index
    http_cache_forever(public: true) do
      render
    end
  end
end
```
rails5 第一次请求和平常一样去render，但之后的请求cache就会生效，浏览器就会收到“304 not modified”的回应
On first hit, we serve the request normally but, then on each subsequent request cache is revalidated and a “304 Not Modified” response is sent to the browser.

注意:
By using this method, Cache-Control: max-age=3155760000 is set as response header and browser/proxy won’t revalidate the resource back to the server unless force reload is done.
http_cache_forever is literally going to set the headers to cache it for 100 years and developers would have to take extra steps to revalidate it. So, this should be used with extra care.

#Better exception responses in Rails 5 API apps(3/3)
rails4的development模式下，无论是html或是api，只要有异常就会抛出一个html的错误页面

rails5中可以这么配置确保返回的也是json的形式
```
# config/environments/development.rb
config.debug_exception_response_format = :api
```

如果还是要跟以前一样(api的时候也是返回html页面形式的错误),可以这么配置
```
# config/environments/development.rb
config.debug_exception_response_format = :default
```

#Use file_fixture to access test files in Rails 5(3/2)
在测试的时候有时候会需要引入文件用来测试，
rails4中
File.read(Rails.root.to_s + "/tests/support/files/#{name}")
rails5中
file_fixture('posts.json').read
存放路径test/fixtures/files

#Migrations are versioned in Rails 5(3/1)
rails 5中自动给timestamps加上了NOT NULL的限制,不需要在migration中再特别去指定(t.timestamps null: false)

rails g model Task user:references
rails4中
t.references :user, index: true, foreign_key: true
rails5
t.references :user, foreign_key: true
虽然在rails5中没指定index: true, 在实际上migration的时候rails5会自动为user_id(references)增加index

考虑到rails4的项目升级到rails5，这些migrate文件会由于timestamps和references的不同，导致创建出不同的schema文件来，这里就要用到Versioned migrations
```
class CreateTasks < ActiveRecord::Migration[5.0]
end

class CreateTasks < ActiveRecord::Migration[4.2]
end
```

---------------------------------------------------------------------------------------------------------------------

#Rails 5 improves searching for routes with advanced options(2/16)
```
rake routes ==> rails routes
rake routes | grep products  ==> rails routes -c products
# Search for namespaced Controller name.
rails routes -c Admin::UsersController
rails routes -c admin/users
```
Pattern specific search
```
# Search with pattern
rails routes -g wishlist
# Search with HTTP Verb
rails routes -g POST
# Search with URI pattern
rails routes -g admin
```

#Active Support Improvements in Rails 5(2/17)
1.Improvements in Date, Time and Datetime
```
Time.current.next_day
Time.current.prev_day
#rails4
Time.current.next_week
Time.current.next_week(:tuesday)
#rails5
Time.current.next_week(same_time: true)

Time.current.tomorrow.on_weekend?
Time.current.on_weekday?
Time.current.next_weekday
Time.current.prev_weekday

Time.days_in_year #366
Time.days_in_year(2015)  #365
```
2.Improvements in Enumerable
```
users = [{id: 1, name: 'Max'}, {id: 2, name: 'Mark'}, {id: 3, name: 'George'}]

users.pluck(:name)
=> ["Max", "Mark", "George"]

# Takes multiple arguments as well
users.pluck(:id, :name)
=> [[1, "Max"], [2, "Mark"], [3, "George"]]

# In Rails 5(在rails4中pluck会触发查询)
users = User.all
SELECT "users".* FROM "users"
# does not fire any query
users.pluck(:id, :name)
=> [[1, "Max"], [2, "Mark"], [3, "George"]]
```

```
vehicles = ['Car', 'Bike', 'Truck', 'Bus']

vehicles.without("Car", "Bike")
=> ["Truck", "Bus"]

vehicles = {car: 'Hyundai', bike: 'Honda', bus: 'Mercedes', truck: 'Tata'}

vehicles.without(:bike, :bus)
=> {:car=>"Hyundai", :truck=>"Tata"}
```
```
['a', 'b', 'c', 'd', 'e'].second_to_last
=> "d"

['a', 'b', 'c', 'd', 'e'].third_to_last
=> "c"
```
Integer#positive? and Integer#negative?

ArrayInquirer
http://qiita.com/QUANON/items/c70c938d5bf2f52c7863
```
users = [:mark, :max, :david]

array_inquirer1 = ActiveSupport::ArrayInquirer.new(users)
# creates ArrayInquirer object which is same as array_inquirer1 above
array_inquirer2 = users.inquiry

array_inquirer2.class
=> ActiveSupport::ArrayInquirer

# provides methods like:
array_inquirer2.mark?
=> true

array_inquirer2.john?
=> false
array_inquirer2.include?(:mark)
#=> true

array_inquirer2.any?(:john, :mark)
=> true

array_inquirer2.any?(:mark, :david)
=> true
array_inquirer2.any?("mark", "david")
=> true

array_inquirer2.any?(:john, :louis)
=> false
```

#Rails 5 handles DateTime with better precision

#Rails 5 allows configuring queue name for mailers
```
config.action_mailer.deliver_later_queue_name = 'default'

class UserMailer < ApplicationMailer
  def send_notification(user)
    @user = user
    mail(to: user.email)
  end
end
```

#Rails 5 improves redirect_to :back with new redirect_back method
In Rails 5, redirect_to :back has been deprecated and instead a new method has been added called redirect_back
```
#rails4
class PostsController < ApplicationController
  rescue_from ActionController::RedirectBackError, with: :redirect_to_default

  def publish
    post = Post.find params[:id]
    post.publish!
    redirect_to :back
  end

  private

  def redirect_to_default
    redirect_to root_path
  end
end
#rails4 中当HTTP_REFERER为空时，会抛出异常, 需要通过捕捉异常的方式来处理

#rails5
class PostsController < ApplicationController

  def publish
    post = Post.find params[:id]
    post.publish!

    redirect_back(fallback_location: root_path)
  end
end
```
