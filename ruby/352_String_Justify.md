```
require "logger"
logger = Logger.new($stderr)
logger.formatter = ->(severity, datetime, progname, message) {
  "#{severity} #{message}\n"
}

logger.info "Ready for launch"
logger.error "Launch clamp malfunction"
logger.info "Resetting launch clamp sensor"
logger.info "Igniting engines"
logger.error "Launch clamps still engaged"
logger.fatal "Aborting launch"


# !> INFO Ready for launch
# !> ERROR Launch clamp malfunction
# !> INFO Resetting launch clamp sensor
# !> INFO Igniting engines
# !> ERROR Launch clamps still engaged
# !> FATAL Aborting launch
没有对其


左对齐
require "logger"
logger = Logger.new($stderr)
logger.formatter = ->(severity, datetime, progname, message) {
  "%-5s %s\n" % [severity, message]
}

# !> INFO  Ready for launch
# !> ERROR Launch clamp malfunction
# !> INFO  Resetting launch clamp sensor
# !> INFO  Igniting engines
# !> ERROR Launch clamps still engaged
# !> FATAL Aborting launch

右对齐
require "logger"
logger = Logger.new($stderr)
logger.formatter = ->(severity, datetime, progname, message) {
  "#{severity.to_s.rjust(5)} #{message}\n"
}

# !>  INFO Ready for launch
# !> ERROR Launch clamp malfunction
# !>  INFO Resetting launch clamp sensor
# !>  INFO Igniting engines
# !> ERROR Launch clamps still engaged
# !> FATAL Aborting launch

```

```
schedule = [
  {name: "Northeast Zephyr", time: "8:36 AM"},
  {name: "Western Cannonball", time: "12:18 PM"},
  {name: "Southern Greased Pig", time: "4:27 PM"},
]

name_width = schedule.map{ |t| t[:name].size }.max
time_width = schedule.map{ |t| t[:time].size }.max

puts "Name".center(name_width) + " " + "Time".center(time_width)
puts "-" * (name_width + time_width + 1)
schedule.each do |train|
  puts train[:name].ljust(name_width) + " " + train[:time].rjust(time_width)
end

# >>         Name           Time
# >> -----------------------------
# >> Northeast Zephyr      8:36 AM
# >> Western Cannonball   12:18 PM
# >> Southern Greased Pig  4:27 PM
```

```
schedule = [
  {name: "Northeast Zephyr", time: "8:36 AM"},
  {name: "Western Cannonball", time: "12:18 PM"},
  {name: "Southern Greased Pig", time: "4:27 PM"},
]

name_width = schedule.map{ |t| t[:name].size }.max
time_width = schedule.map{ |t| t[:time].size }.max

puts "Name".center(name_width) + " " + "Time".center(time_width)
puts "-" * (name_width + time_width + 1)
schedule.each do |train|
  puts train[:name].ljust(name_width, ".") +
       "." +
       train[:time].rjust(time_width, ".")
end

# >>         Name           Time
# >> -----------------------------
# >> Northeast Zephyr......8:36 AM
# >> Western Cannonball...12:18 PM
# >> Southern Greased Pig..4:27 PM
```
