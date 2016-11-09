### install java8
```
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer
```

### install elasticsearch
```
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
sudo apt-get update && sudo apt-get install elasticsearch
```
sudo vi /etc/elasticsearch/elasticsearch.yml
你应该限制外网访问Elasticsearch服务（端口9200），这样可以禁止外部用户通过HTTP API访问数据。找到 network.host，去掉注释并改为localhost，如下：
```
network.host: localhost
```
启动Elasticsearch：
```
sudo service elasticsearch restart
```
设置开机自启：
```
sudo update-rc.d elasticsearch defaults 95 10
```

### install Kibana
```
sudo groupadd -g 999 kibana
sudo useradd -u 999 -g 999 kibana
```
```
cd ~; wget https://download.elastic.co/kibana/kibana/kibana-4.6.1-linux-x86_64.tar.gz
tar xvf kibana-*.tar.gz
vi ~/kibana-4*/config/kibana.yml
```
找到server.host，替换IP地址为 “localhost”：
```
server.host: "localhost"
```
把Kibana放在适当的目录：
```
sudo mkdir -p /opt/kibana
sudo cp -R ~/kibana-4*/* /opt/kibana/
sudo chown -R kibana: /opt/kibana
```
```
cd /etc/init.d && sudo curl -o kibana https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/fc5025c3fc499ad8262aff34ba7fde8c87ead7c0/kibana-4.x-init
cd /etc/default && sudo curl -o kibana https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/fc5025c3fc499ad8262aff34ba7fde8c87ead7c0/kibana-4.x-default
```
```
sudo chmod +x /etc/init.d/kibana
sudo update-rc.d kibana defaults 96 9
sudo service kibana start
```

### install nginx
```
sudo apt-get install nginx apache2-utils
```
用 htpasswd 创建管理员用户：
```
sudo htpasswd -c /etc/nginx/htpasswd.users kibanaadmin
```
kibanaadmin为管理员名称，修改为你想要的。

配置Nginx默认服务块：
```
sudo vi /etc/nginx/sites-available/default
```
清空文件内容，拷贝：
```
server {
    listen 80;

    server_name example.com;

    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/htpasswd.users;

    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
server_name 修改为你的。Nginx重定向HTTP到Kibana（监听localhost:5601），并用htpasswd.users文件验证用户名。

重启
```
sudo service nginx restart
```
现在在浏览器输入http://logstash_server_public_ip/ 访问Logstash服务器，输入kibanaadmin用户名，就可以看到欢迎界面了。

### install logstash
```
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://packages.elastic.co/logstash/2.4/debian stable main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update && sudo apt-get install logstash
```




### install beats
```
curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://packages.elastic.co/beats/apt stable main" |  sudo tee -a /etc/apt/sources.list.d/beats.list
sudo apt-get update && sudo apt-get install filebeat

sudo vi /etc/filebeat/filebeat.yml
```

```
paths:
- /home/deploy/app/feedmob_tracking/shared/log/sidekiq.log
- /home/deploy/app/feedmob_tracking/shared/log/production.log
- /home/deploy/app/feedmob_tracking/shared/log/unicorn.stderr.log

logstash:
hosts: ["log.techbay.club:5043"]

```

```
sudo service filebeat restart
sudo update-rc.d filebeat defaults 95 10
```

* http://blog.topspeedsnail.com/archives/272
* http://www.ttlsa.com/elk/migration-logtash-forwarder-to-filebeat/
* http://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/setup-elk-stack-ubuntu-16-04.html
* https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-16-04
