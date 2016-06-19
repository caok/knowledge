```
tasks = [{"id"=>1, "title"=>"Pick a topic", "completed"=>false, "url"=>"http://localhost:3000/tasks/1.json"}, {"id"=>2, "title"=>"Compose script", "completed"=>false, "url"=>"http://localhost:3000/tasks/2.json"}, {"id"=>3, "title"=>"Record screen", "completed"=>false, "url"=>"http://localhost:3000/tasks/3.json"}, {"id"=>4, "title"=>"Record VO", "completed"=>false, "url"=>"http://localhost:3000/tasks/4.json"}, {"id"=>5, "title"=>"Produce video", "completed"=>false, "url"=>"http://localhost:3000/tasks/5.json"}, {"id"=>6, "title"=>"Export video", "completed"=>false, "url"=>"http://localhost:3000/tasks/6.json"}, {"id"=>7, "title"=>"Post episode", "completed"=>false, "url"=>"http://localhost:3000/tasks/7.json"}]

require "pp"
pp tasks

require "awesome_print"
ap tasks
ap tasks, limit: 3

AwesomePrint.irb!
tasks

s = "hello"
ap s.methods
```
