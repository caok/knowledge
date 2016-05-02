### [jenkins](https://jenkins-ci.org/)
#### Installation
```
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```

#### Upgrade
```
sudo apt-get update
sudo apt-get install jenkins
```

#### Setting up an Nginx Proxy for port 80 -> 8080
##### Install Nginx.
```
sudo aptitude -y install nginx
```

##### Remove default configuration.
```
cd /etc/nginx/sites-available
sudo rm default ../sites-enabled/default
```

##### Create new configuration for Jenkins.
```
sudo vi jenkins

upstream app_server {
    server 127.0.0.1:8080 fail_timeout=0;
}
server {
    listen 80;
    listen [::]:80 default ipv6only=on;
    server_name ci.yourcompany.com;

    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;

        if (!-f $request_filename) {
            proxy_pass http://app_server;
            break;
        }
    }
}
```

##### Link your configuration from sites-available to sites-enabled:
```
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
```

##### Restart Nginx
```
sudo service nginx restart
```

#### 忘记管理员账号密码的补救方法
目录: /var/lib/jenkins/config.xml

删除该文件中的以下部分
```
<useSecurity>true</useSecurity>
<authorizationStategy class="hudson.sucrity.FullControlOnceLoggedInAuthorizationStrategy">
    ......
</authorizationStategy>
<securityRealm class="hudson.security.HudsonPrivateSecurityRealm">
    .. 
</securityRealm>
```

重启
```
sudo service jenkins restart
```

##### 创建jenkins系统用户
```
sudo adduser --disabled-login --gecos 'Jenkins' jenkins
```

##### 切换成jenkins用户
```
sudo su - jenkins
```
### Create a .gitconfig in the home directory (/var/lib/jenkins)
```
[user]
  name = Jenkins
  email = jenkins@localhost
```

https://dpsk.github.io/blog/2013/07/26/install-jenkins-ci-for-rails-project-with-cucumber/

在默认sudo的帐户下安装依赖，然后切换到jenkins用户下，通过安装rbenv和ruby

```
#!/bin/bash -x
export PATH="/home/jenkins/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv global 2.2.0

cp config/application.example.yml config/application.yml

bundle install
RAILS_ENV=test rake db:drop
RAILS_ENV=test rake db:create
RAILS_ENV=test rake db:test:prepare
RAILS_ENV=test cucumber
```

http://blog.csdn.net/stwstw0123/article/details/47342979
