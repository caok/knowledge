```
Process.spawn "echo Current user is: $USER"
 
# >> Current user is: clark
```

```
Process.spawn({"USER" => "crow"}, "echo Current user is: $USER")
 
# >> Current user is: crow
```

```
Process.spawn({}, "echo Current user is: $USER", unsetenv_others: true)

system({"USER" => "JACK"}, "echo Current user is $USER", unsetenv_others: true)
```
