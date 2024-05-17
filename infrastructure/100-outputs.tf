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
  value = any([
    for db in aws_instance.db : 
    db.associate_public_ip_address == true
  ])
}

output "instances_state" {
  value = alltrue([
    for httpd in concat(aws_instance.http, aws_instance.db) :
    httpd.instance_state == "running"
  ])
}