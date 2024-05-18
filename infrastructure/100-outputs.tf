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

output "db_public_access" {
  value = length([
    for db in aws_instance.db : db.associate_public_ip_address
    if db.associate_public_ip_address == false
  ]) != length(aws_instance.db)
}

output "httpd_state" {
  value = alltrue([
    for httpd in aws_instance.http :
    httpd.instance_state == "running" ? true : false
  ])
}

output "db_state" {
  value = alltrue([
    for db in aws_instance.db :
    db.instance_state == "running" ? true : false
  ])
}

output "cidr" {
  value = alltrue(
    [var.vpc_cidr == aws_vpc.terraform.cidr_block == "192.168.0.0/16",
    var.network_http.cidr == aws_subnet.http.cidr_block == "192.168.1.0/24",
    var.network_db.cidr == aws_subnet.db.cidr_block == "192.168.2.0/24"]
  )
}