provider "aws" {
  region = var.region
}

# 自动读取安全组
data "aws_security_group" "default" {
    filter {
      name="group-name"
      values=["default"]
    }
  
}

resource "aws_instance" "webgd" {
    ami = lookup(var.amis,var.region)
        instance_type = var.instance_type
        key_name = aws_key_pair.SSH.key_name
        user_data = file("setup_nginx.sh")
        tags={
            Name = "nginx-web-server"
        }
 
}

# 添加免密
resource "aws_key_pair" "ssh" {
  key_name="admin"
  public_key=file(var.public_key)

}

#22端口，ssh
resource "aws_security_group_rule" "ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = data.aws_security_group.default.ids[0]
}