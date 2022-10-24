provider "aws" {
  region = var.region
}

# 自动读取安全组
data "aws_security_group" "default" {
    filter {
      name = "group-name"
      values = ["default"]
    }
  
}
# 添加免密
resource "aws_key_pair" "ssh" {
  key_name="admin"
  public_key=file(var.public_key)

}

resource "aws_instance" "webgd" {
    ami = lookup(var.amis, var.region)
        instance_type = var.instance_type
        key_name = aws_key_pair.ssh.key_name
        user_data = templatefile("setup_nginx.sh",{time= timestamp(),contents ="this is a demo for tf in ec2"})
        tags={
            Name = "nginx-web-server"
        }
 connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("id_rsa")
    host = aws_instance.webgd.public_ip
    }

provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
    }

provisioner "remote-exec" {
inline = [
    "chmod +x /tmp/script.sh",
    "/tmp/script.sh",
    ]
    }


}

#22端口，ssh
resource "aws_security_group_rule" "ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = data.aws_security_group.default.id
}

#80端口，web
resource "aws_security_group_rule" "webgd" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = data.aws_security_group.default.id
}

#8080端口，容器内httpd
resource "aws_security_group_rule" "httpdgd" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = data.aws_security_group.default.id
}