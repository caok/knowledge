```
安装（需要 Ruby）：
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
搜索：brew search mysql
查询：brew info mysql 主要看具体的信息，比如目前的版本，依赖，安装后注意事项等
更新：brew update 这会更新 Homebrew 自己，并且使得接下来的两个操作有意义——
检查过时（是否有新版本）：brew outdated 这回列出所有安装的软件里可以升级的那些
升级：brew upgrade 升级所有可以升级的软件们
清理：brew cleanup 清理不需要的版本极其安装包缓存
安装：brew install mysql
卸载：brew uninstall mysql
```

```
brew list           列出已安装的软件
brew home       用浏览器打开brew的官方网站
brew deps        显示包依赖
```

```
brew update          # 更新 Homebrew 的信息
brew outdated        # 看一下哪些软件可以升级
brew upgrade <xxx>   # 如果不是所有的都要升级，那就这样升级指定的
brew upgrade; brew cleanup    # 如果都要升级，直接升级完然后清理干净
```
