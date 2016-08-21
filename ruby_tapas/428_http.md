https://github.com/httprb/http

gem install http

```
require "http"
response = HTTP.get("http://www.rubytapas.com")

response.status                 # => #<HTTP::Response::Status 200 OK>
response.status.success?        # => true
response.content_type           # => #<struct HTTP::ContentType mime_type="text/html", charset="UTF-8">
response.body.to_s.size         # => 105776
```

```
require "http"

HTTP.accept("application/json")
    .get("http://example.org/api/list")

HTTP.accept("application/json")
    .basic_auth(user: "frodo", password: "friend")
    .get("http://example.org/api/list")
```

```
require "http"
 
client = HTTP.accept("application/json")
             .basic_auth(user: "frodo", password: "friend")
```

```
require "http"
 
client = HTTP.accept("application/json")
             .basic_auth(user: "frodo", password: "friend")
             
client.get("http://example.org/api/list")
client.get("http://example.org/api/show/1")
```

```
require "http"
 
client = HTTP.persistent("http://example.org")
             .accept("application/json")
             .basic_auth(user: "frodo", password: "friend")
 
client.get("/api/list")
client.get("/api/show/1")
```

For instance, if we wanted just one request to automatically follow redirects, we could add that on:
```
require"http"
 
client = HTTP.persistent("http://example.org")
           .accept("application/json")
           .basic_auth(user: "frodo", password: "friend")
 
client.get("/api/list")
client.follow.get("/api/show/1")For instance, if we wanted just one request to automatically follow redirects, we could add that on:

```
