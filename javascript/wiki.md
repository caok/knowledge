### 通过js检查上传图片的尺寸大小
```
# https://jsfiddle.net/4N6D9/1/
<input type="file" id="file" />

var _URL = window.URL || window.webkitURL;
$("#file").change(function(e) {
  var file, img;
  
  if ((file = this.files[0])) {
    img = new Image();
    img.onload = function() {
      alert(this.width + " " + this.height);
    };
    img.onerror = function() {
      alert( "not a valid file: " + file.type);
    };
    img.src = _URL.createObjectURL(file);
  }
});
```
