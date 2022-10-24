output "DNS" {
  value = aws_instance.webgd.public_dns
  description = "EC2 public DNS"
}

output "IP" {
  value = aws_instance_webgd_public_ip
    description = "EC2 public IP"
}