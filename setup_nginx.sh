#!/bin/bash
#安装和启动nginx
sudo apt update
sudo apt install -y nginx
sudo timedatectl set-timezone Asia/Shanghai
echo Created:${time}+${contents} | sudo tee /var/www/html/index.html
