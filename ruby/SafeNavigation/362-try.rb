```
@product.department &&
  @product.department.curator &&
  @product.department.curator.email_address
# => "dan@example.com"


@product.try(:department).try(:curator).try(:email_address)


num = "23.1"
num.try!(:floor)   #抛出异常

@product&.department&.curator&.email_address
# ruby2.3之前使用
@product.?department.?curator.?email_address
```

 the &. syntax only skips nil

 ```
account = Account.new(owner: false)

account.owner.address
# => NoMethodError: undefined method 'address' for false:FalseClass 

account && account.owner && account.owner.address
# => false

account.try(:owner).try(:address)
# => nil

account&.owner&.address
# => undefined method 'address' for false:FalseClass


###########################
ccount = Account.new(owner: Object.new)

account.owner.address
# => NoMethodError: undefined method 'address' for #<Object:0x00559996b5bde8>

account && account.owner && account.owner.address
# => NoMethodError: undefined method 'address' for #<Object:0x00559996b5bde8>

account.try(:owner).try(:address)
# => nil

account&.owner&.address
# => NoMethodError: undefined method 'address' for #<Object:0x00559996b5bde8>
 ```

dig  is available on all Hash, Array, and Struct objects in Ruby 2.3.
 ```
require "json"

forecast = JSON.parse(File.read("forecast.json"))

forecast.fetch("list", [])
  .fetch(40, {})
  .fetch("main", {})
  .fetch("temp_min", nil)

forecast&.["list"]&.[39]&.["main"]&.["temp_min"]

forecast.dig("list", 39, "main", "temp_min")
 ```
