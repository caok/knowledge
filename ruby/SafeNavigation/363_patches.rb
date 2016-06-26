
# So, we've now seen a similarity in behavior between Ruby variables,
# and arrays containing one element. But how does this help us?

# What if we could treat /any/ object as if it was an array of zero or
# one element?

# This is pretty easy to do with some simple patches.

# The =Object= base class gains an =#each= method. To comply with
# convention, it starts out with an enumerator conversion, as seen in
# episode #64. Then it simply yields itself to the given block. In order
# to mimic the standard definition of =#each=, it returns =nil=.

# The implementation of =#map= is even simpler, since it can return the
# result of the yield.

# Next, we modify =NilClass=. Here, there are no yields. The
# implementation of =#each= simply returns =nil=, and the implementation
# of =#map= returns an empty array.

class Object
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

class NilClass
  def each
    return to_enum(__callee__) unless block_given?
    nil
  end

  def map
    return to_enum(__callee__) unless block_given?
    nil
  end
end
