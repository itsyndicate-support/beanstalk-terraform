# Display dns information

output "http_ip" {
  value = {
    for instance in aws_instance.http :
    instance.id => instance.private_ip
  }
}

output "db_ip" {
  value = {
    for instance in aws_instance.db :
    instance.id => instance.private_ip
  }
}

# Terratest outputs
output "http_instance_names" {
  value = [for instance in aws_instance.http : instance.tags.Name]
}

output "db_instance_names" {
  value = [for instance in aws_instance.db : instance.tags.Name]
}


output "http_instance_public_ips" {
  value = [for instance in aws_instance.http : instance.public_ip]
}

output "db_instance_public_ips" {
  value = [for instance in aws_instance.db : instance.public_ip if instance.public_ip != ""]
}

output "vpc_cidr" {
  value = aws_vpc.terraform.cidr_block
}

output "http_subnet_cidr" {
  value = aws_subnet.http.cidr_block
}

output "db_subnet_cidr" {
  value = aws_subnet.db.cidr_block
}