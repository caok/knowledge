
# This is long and ugly and a pain to read and maintain.

# Now, I'm going to stop right here for a moment and say that this looks
# ugly for a reason. Every =nil=-check is a type-check, and
# well-designed object-oriented programs should almost never need to
# check an object's type. The /whole point/ of OO is being able to
# confidently send messages to objects without worrying about how they
# will handle those messages. And without constantly branching on object
# types.

# Code like this usually points to a deeper problem: structural
# coupling. Every time we add a line of code that steps through this
# chain of connections, we tie another part of our program to the deep
# structure of the objects as they exist right now. If the relationships
# of objects should ever change, it will break every line where we tied
# our code to the deep structure.

# In the next few episodes we're going to explore some strategies for
# performing so-called "safe-navigation" across networks of objects like
# this one. But before we get into that, I think we should talk a little
# bit about how we can avoid the need for "safe navigation" in the first
# place.

# In various episodes we've examined patterns for eliminating spurious
# =nil= values from our code. For instance, in episode #114 we learned
# about the Null Object pattern, where we provide do-nothing objects
# whose job is to respond to expose the expected interface even in the
# absence of a "real" object.

# Here are the model classes for this little example. They are extremely
# basic. We know that in order to use the =Product#department= attribute
# confidently, we need to be sure that it will always return something
# that behaves /like/ a department---even if no department has been
# explicitly assigned yet.

# At the same time, it is not =Product='s job to know exactly what a
# department /should/ behave like. So let's punt the question to the
# =Department= class, and assign a default value of =Department.null=.

# What is =Department.null=? That's what we have to decide next. Let's
# start its definition.

# As suggested by the name, we want to return a "null object" of some
# kind; some object which represents the /absence/ of an assigned
# department, without being =nil=.

# Now, there are lots of different choices in how to define a null
# object. And if you're interested in learning about some of those
# options, check out the [[http://github.com/avdi/naught][=naught= gem]] that I wrote.

# But today, we're going to use what is perhaps the simplest possible
# form of null object: we're just going to define a special instance of
# the class to play the roll of null.

# We only need one null instance, so we conditionally assign to a class
# instance variable called =@null=. In it we put a new Department
# instance, with a name that makes it clear that this is the null
# department.

# Then we go into the initializer, and just as we did for =Product='s
# =department= attribute, we give =Department= objects a default non-nil
# =curator= association. Once again, we delegate to the associated class
# to define a suitable null version.

# We go through the whole process over again for =Curator=. The only
# difference this time, is that we're not sure what kind of default
# value to give to the =email_address= attribute of a missing curator.
# We decide that since the =email_address= is used more for its value
# rather than for its behavior, it makes sense in this case to leave it
# with the default =nil= value.

class Product
  attr_accessor :department

  def initialize(name)
    @name = name
    @department = Department.null
  end
end

class Department
  def self.null
    @null ||= new("<Missing Department>")
  end

  attr_accessor :curator
  def initialize(name)
    @name = name
    @curator = Curator.null
  end
end

class Curator
  def self.null
    @null ||= new("<Missing Curator>")
  end

  attr_accessor :email_address
  def initialize(name)
    @name = name
  end
end
