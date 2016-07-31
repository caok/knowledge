```
 rss_info = {
   published_at: Time.new(2016, 01, 01)
 }

 published_at = rss_info&.fetch(:published_at) || Time.now
 published_at                    # => 2016-01-01 00:00:00 -0500
```
the &. syntax only skips nil
fetch如果没有对应的key的话会抛出异常

```
{foo: 23}.fetch(:bar) # ~> KeyError: key not found: :bar
```

```
rss_info = nil
 
rss_info&.fetch(:published_at)  #=> nil
published_at = rss_info&.fetch(:published_at) || Time.now
published_at                    # => 2016-06-08 17:05:25 -0400
```

```
rss_info = {
  "published_at" => Time.new(2016, 01, 01)
}
 
published_at = (rss_info && rss_info[:published_at]) || Time.now
published_at                    # => 2016-06-08 17:55:06 -0400
```

```
rss_info = {
  "published_at" => Time.new(2016, 01, 01)
}
 
published_at = rss_info&.fetch(:published_at) || Time.now # ~> KeyError: key not found: :published_at
published_at                    # =>
 
# ~> KeyError
# ~> key not found: :published_at
# ~>
# ~> xmptmp-in6215jUt.rb:5:in `fetch'
# ~> xmptmp-in6215jUt.rb:5:in `<main>'
```
