### 图片上传时，原先时put请求的自动变为post请求
active admin 中在处理有图片的form时也可以同样处理
```
<%= form_for :creative, url: wizard_path, :html => {:multipart => true, :method => :put} do |f| %>

or active_admin 中
form :html => { :enctype => "multipart/form-data" } do |f|
  f.inputs :multipart => true do
    f.input :name, :input_html => { disabled: true, readonly: true }
    f.input :pic1, as: :file, hint: "Recommend size: 300x140 max: 200KB"
  end
  f.actions
end
```
