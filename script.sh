#!/bin/bash
#step 1: 安装必要的一些系统工具
sudo apt-get update
wait
sudo sleep 5
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
wait

#step 2: 安装GPG证书
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
wait
sudo sleep 5
#Step 3: 写入软件源信息
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y

wait
sudo sleep 5
#Step 5: 更新
sudo apt-get -y update
wait
sudo sleep 5

#Step 7 : 安装Docker-CE
sudo apt-get -y install docker-ce docker-ce-cli docker-compose-plugin

wait
sudo sleep 5
#Step 8 :配置镜像加速器
#创建文件夹
sudo mkdir -p /etc/docker

# 创建文件
sudo tee /etc/docker/daemon.json <<-'EOF'
{
   "registry-mirrors": [
   "https://hub.docker.com/",
   "https://cvrshm0p.mirror.aliyuncs.com",
   "https://hub-mirror.c.163.com",
   "https://docker.mirrors.ustc.edu.cn"]
}
EOF
wait 

#Step 9 重新载入
sudo systemctl daemon-reload

# 重启服务
sudo systemctl restart docker
wait
sleep 3


#Step 10 拉取一个httpd的镜像，端口映射，并修改应用
sudo docker run --name a1 -p 8080:80 -d httpd
sudo docker exec a1 bash -c "echo 'this is in container http service' > /usr/local/apache2/htdocs/index.html"
exit