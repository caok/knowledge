
# These two versions are in many ways very similar to each other. But
# the second one re-uses syntax and techniques that are already familiar
# to us from manipulating collections.

# The advantage here is in more than just familiarity. Consider this new
# scenario: the structure of our models changes. Instead of having a
# single, optional department, a product now has a list of departments
# that it may exist in.

class Product
  attr_accessor :departments
  def initialize(name)
    @name        = name
    @departments = []
  end
end

class Department
  attr_accessor :curator
  def initialize(name)
    @name = name
  end
end

class Curator
  attr_accessor :email_address
  def initialize(name)
    @name = name
  end
end

@product = Product.new("Bass-O-Matic")
@product.departments << Department.new("Kitchen")
@product.departments << Department.new("Fishing")
@product.departments[0].curator = Curator.new("Dan Akroyd")
@product.departments[0].curator.email_address = "dan@example.com"
@product.departments[1].curator = Curator.new("Jane Curtain")
@product.departments[1].curator.email_address = "jane@example.com"
