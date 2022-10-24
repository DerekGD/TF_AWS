variable "region" {
  type = string
  default = "ap-east-1"
  description = "ASW region"
}

//ubuntu 22.04
variable "amis" {
  type = map
  default = {
  ap-east-1 = "ami-0ad5e5b79f0def493"
  }
  description = "AMI ID"
}

#ec2 实例类型
variable "instance_type"{
    type=string
    default="t3.micro"
    description="EC2 instance type"
}

# 公钥
variable "public_key"{
    type=string
    default="id_rsa.pub"
    description="SSH public key"
}

