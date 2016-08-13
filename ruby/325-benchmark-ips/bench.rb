Event = Struct.new(:name, :source, :args)
 
class TestBed
  attr_reader :event_log
 
  def initialize
    @event_log = []
  end
end
 
class HardcodeTestbed < TestBed
  def call(event)
    case event.name
    when :foo
      handle_foo(event)
    when :bar
      handle_bar(event)
    when :baz
      handle_baz(event)
    end
  end
 
  def handle_foo(event)
    event_log << event
  end
 
  def handle_bar(event)
    event_log << event
  end
 
  def handle_baz(event)
    event_log << event
  end
end
 
class SendTestbed < TestBed
  def call(event)
    handler_name = "handle_#{event.name}"
    __send__(handler_name, event) if respond_to?(handler_name)
  end
 
  def handle_foo(event)
    event_log << event
  end
 
  def handle_bar(event)
    event_log << event
  end
 
  def handle_baz(event)
    event_log << event
  end
end
 
class SendTableTestbed < TestBed
  def self.method_added(method_name)
    if method_name.to_s =~ /\Ahandle_(.+)\z/
      handler_methods[$1.to_sym] = method_name.to_sym
    end
    super
  end
 
  def self.handler_methods
    @handler_methods ||= {}
  end
 
  def call(event)
    if (handler_method = self.class.handler_methods[event.name])
      __send__(handler_method, event)
    end
  end
 
  def handle_foo(event)
    event_log << event
  end
 
  def handle_bar(event)
    event_log << event
  end
 
  def handle_baz(event)
    event_log << event
  end
end
 
class BindTableTestbed < TestBed
  def self.method_added(method_name)
    if method_name.to_s =~ /\Ahandle_(.+)\z/
      handler_methods[$1.to_sym] = instance_method(method_name)
    end
    super
  end
 
  def self.handler_methods
    @handler_methods ||= {}
  end
 
  def call(event)
    if (handler_method = self.class.handler_methods[event.name])
      handler_method.bind(self).call(event)
    end
  end
 
  def handle_foo(event)
    event_log << event
  end
 
  def handle_bar(event)
    event_log << event
  end
 
  def handle_baz(event)
    event_log << event
  end
end
 
class CodeGenTestbed < TestBed
  def self.method_added(method_name)
    if method_name.to_s =~ /\Ahandle_(.+)\z/
      handler_methods << $1
      regenerate_dispatch_method
    end
    super
  end
 
  def self.handler_methods
    @handler_methods ||= []
  end
 
  def self.regenerate_dispatch_method
    dispatch_table = handler_methods.map { |event_name|
      "when :#{event_name} then handle_#{event_name}(event)"
    }.join("\n")
    class_eval %{
      def call(event)
        case event.name
        #{dispatch_table}
        end
      end
    }
  end
 
  def handle_foo(event)
    event_log << event
  end
 
  def handle_bar(event)
    event_log << event
  end
 
  def handle_baz(event)
    event_log << event
  end
end
 
class IfCodeGenTestbed < TestBed
  def self.method_added(method_name)
    if method_name.to_s =~ /\Ahandle_(.+)\z/
      handler_methods << $1
      regenerate_dispatch_method
    end
    super
  end
 
  def self.handler_methods
    @handler_methods ||= []
  end
 
  def self.regenerate_dispatch_method
    dispatch_table = handler_methods.map { |event_name|
      "event.name.equal?(:#{event_name}) then handle_#{event_name}(event)"
    }.join("\nelsif ")
    class_eval %{
      def call(event)
        if #{dispatch_table}
        end
      end
    }
  end
 
  def handle_foo(event)
    event_log << event
  end
 
  def handle_bar(event)
    event_log << event
  end
 
  def handle_baz(event)
    event_log << event
  end
end
 
def do_test(klass)
  testbed = klass.new
  testbed.call(e1 = Event[:foo])
  testbed.call(e2 = Event[:bar])
  testbed.call(e3 = Event[:baz])
  testbed.call(Event[:buz])
  unless testbed.event_log == [e1, e2, e3]
    fail "#{klass}: #{testbed.event_log.inspect}"
  end
end
 
classes = [
    HardcodeTestbed,
    SendTestbed,
    SendTableTestbed,
    BindTableTestbed,
    CodeGenTestbed,
    IfCodeGenTestbed,
]
width   = classes.map(&:name).map(&:size).max
 
#require "benchmark"
#n = 1000_000
#Benchmark.bmbm(16) do |x|
  #classes.each do |klass|
    #x.report(klass.name) do
      #n.times do
        #do_test(klass)
      #end
    #end
  #end
#end

require "benchmark/ips"
Benchmark.ips do |x|
  classes.each do |klass|
    x.report(klass.name) do
      do_test(klass)
    end
    x.compare!
  end
end

##############################################################################
# Calculating -------------------------------------
#      HardcodeTestbed    38.468k i/100ms
#          SendTestbed    20.666k i/100ms
#     SendTableTestbed    29.470k i/100ms
#     BindTableTestbed    22.667k i/100ms
#       CodeGenTestbed    39.616k i/100ms
#     IfCodeGenTestbed    38.571k i/100ms
# -------------------------------------------------
#      HardcodeTestbed    576.640k (± 1.3%) i/s -      2.885M
#          SendTestbed    268.347k (± 1.3%) i/s -      1.343M
#     SendTableTestbed    412.413k (± 1.0%) i/s -      2.063M
#     BindTableTestbed    224.491k (±26.8%) i/s -      1.020M
#       CodeGenTestbed    459.260k (±15.1%) i/s -      2.258M
#     IfCodeGenTestbed    501.894k (± 9.4%) i/s -      2.507M
#  
# Comparison:
#      HardcodeTestbed:   576640.3 i/s
#     IfCodeGenTestbed:   501894.0 i/s - 1.15x slower
#       CodeGenTestbed:   459260.2 i/s - 1.26x slower
#     SendTableTestbed:   412412.6 i/s - 1.40x slower
#          SendTestbed:   268347.3 i/s - 2.15x slower
#     BindTableTestbed:   224491.1 i/s - 2.57x slower
##############################################################################

# The first column is the most important: it’s the number of iterations per second the code being tested was able to complete. The higher the number, the faster the code.
# 第一列: 每秒被测试的代码可以被迭代的次数，数值越高代码越快
#
# Next up is the percent of standard deviation that the times exhibited. This tells us how variable each iteration was compared to others. These numbers are fairly low, meaning that the repetitions were pretty consistent, and don’t have outliers skewing the results.
# 第二列: 表现出的两倍标准偏差的百分比。这告诉我们，每一次迭代中是如何变比别人。这些数字是相当低的，这意味着重复是相当一致的，并且不具有离群倾斜的结果。
#
# At the end of the line, we see the total number of iterations Benchmark-IPS actually ran in order to get its iterations-per-second average.
