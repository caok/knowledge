
# Now, I imagine that you're having one of two reactions to this
# technique. Either you think this is some of the nuttiest code you've
# ever seen. Or you're nodding along.

# If you're nodding along, it's because you've seen this before. And if
# you have, it's probably because you have some experience in a
# statically-typed functional programming language such as Haskell,
# Scala, or ML. What I've shown you today is a common idiom in those
# languages, where it usually goes by the name of the /option/ or the
# /maybe/ type.

# An Option Type is a type of data that may either have some value, or
# may have a value of "none". And typically you would use the =map=
# function conditionally apply operations to the value, if it is
# present.

# In Ruby, /any/ variable can potentially contain a =nil= value without
# restriction. So it makes sense for us to treat every value as having
# the optional type.

# One reasonable objection you might make to this code is that adding
# =#map= and =#each= to =Object= and =NilClass= are some pretty big
# changes to make to core classes. It's always possible this kind of
# invasive patching might break existing code.

# Which makes these extensions a natural candidate for translation into
# refinements. I know we've talked about refinements before, in episode
# #250. But they are such a useful feature for trying out extensions in
# a safe way that I think it's worth going over the how-to again.

# To make our patches into refinements, we first enclose them in a
# module. Then we change the class declarations into =refine...do=
# statements.

module OptionalEverything
  refine Object do
    def each
      return to_enum(__callee__) unless block_given?
      yield self
      nil
    end

    def map
      return to_enum(__callee__) unless block_given?
      yield self
    end
  end

  refine NilClass do
    def each
      return to_enum(__callee__) unless block_given?
      nil
    end

    def map
      return to_enum(__callee__) unless block_given?
      nil
    end
  end
end
