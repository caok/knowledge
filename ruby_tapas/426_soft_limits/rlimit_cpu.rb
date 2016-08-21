#pid = Process.spawn "ruby ./cpu_asplode.rb", rlimit_cpu: 1
pid = Process.spawn RbConfig.ruby, "./cpu_asplode.rb", rlimit_cpu: [1, 2]
#The first number is the soft limit for CPU usage, in seconds. The second number specifies the hard limit.
Process.waitpid pid
