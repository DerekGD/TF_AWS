#!/bin/bash
#安装和启动nginx
sudo apt update
sudo apt install -y nginx
sudo timedatectl set-timezone Asia/Shanghai
#修改应用软件
echo Created:${time}+${contents} | sudo tee /var/www/html/index.html