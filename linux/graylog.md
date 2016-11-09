### Prerequisites
```
#sudo add-apt-repository ppa:openjdk-r/ppa
#sudo apt-get update
sudo apt-get install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen
```

### MongoDB
```
sudo apt-get install mongodb-server
```

### Elasticsearch
```
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
sudo apt-get update && sudo apt-get install elasticsearch
```
modify the file of "/etc/elasticsearch/elasticsearch.yml"
```
cluster.name: graylog
```
start elasticsearch
```
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl restart elasticsearch.service
```
查看elasticsearch状态
```
curl -XGET 'http://localhost:9200/_cluster/health?pretty=true'
```

### Graylog
安装
```
wget https://packages.graylog2.org/repo/packages/graylog-2.1-repository_latest.deb
sudo dpkg -i graylog-2.1-repository_latest.deb
sudo apt-get update && sudo apt-get install graylog-server
```
修改配置文件(/etc/graylog/server/server.conf)
```
pwgen -N 1 -s 96
=> OH9wXpsNZVBA8R5vJQSnkhTB1qDOjCxAh3aE3LvXddtfDlZlKYEyGS24BJAiIxI0sbSTSPovTTnhLkkrUvhSSxodTlzDi5gP

password_secret = OH9wXpsNZVBA8R5vJQSnkhTB1qDOjCxAh3aE3LvXddtfDlZlKYEyGS24BJAiIxI0sbSTSPovTTnhLkkrUvhSSxodTlzDi5gP

echo -n yourpassword | sha256sum
e3c652f0ba0b4801205814f8b6bc49672c4c74e25b497770bb89b22cdeb4e951

root_password_sha2 = e3c652f0ba0b4801205814f8b6bc49672c4c74e25b497770bb89b22cdeb4e951
```
这里默认用户名为admin，密码为你刚才生成时用的yourpassword
```
rest_listen_uri = http://0.0.0.0:9000/api/
rest_transport_uri = http://0.0.0.0:9000/api/
web_listen_uri = http://0.0.0.0:9000/
```
启动服务
```
sudo systemctl daemon-reload
sudo systemctl restart graylog-server
sudo systemctl enable graylog-server
```
查看服务启动日志
```
sudo tailf /var/log/graylog-server/server.log
```


参考:
* http://docs.graylog.org/en/2.1/pages/installation/os/ubuntu.html
* http://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/how-to-install-graylog-on-ubuntu-16-04.html
