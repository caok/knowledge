```
$stdin                          # => #<IO:<STDIN>>
$stdout                         # => #<IO:<STDOUT>>

open("/dev/urandom")            # => #<File:/dev/urandom>
File.superclass                 # => IO

IO.popen("cowsay") # => #<IO:fd 7>
```

```
require "socket"

TCPSocket.new "google.com", 80
# => #<TCPSocket:fd 7>

TCPSocket.ancestors
# => [TCPSocket, IPSocket, BasicSocket, IO, File::Constants, Enumerable, Object ...]
```
What we can see here is that when we're dealing with files, network connections, or really any kind of stream of data from or to the outside world, when we dig deep enough we usually find the IO class. An IO object is effectively a wrapper around the operating systems concept of a filehandle.

all input and output must be performed via IO objects?
Not all

```
require "tempfile"

temp = Tempfile.new                    # => #<Tempfile:/tmp/20160316-13069-134v9lj>
temp.write "Hello"
temp.close
temp.open
temp.read                       # => "Hello"

Tempfile.ancestors
# => [Tempfile, #<Class:0x0055cfc0f224d0>, Delegator, #<Module:0x0055cfc117fe08>, BasicObject]
```
Tempfile is what is known as an IO-like object. It behaves like an IO object, but isn't directly derived from that class. 
