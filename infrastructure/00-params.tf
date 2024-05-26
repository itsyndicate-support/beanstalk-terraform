# parms file for aws ec2 cloud

#### VPC Network
variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

#### HTTP PARAMS
variable "network_http" {
  type = map(string)
  default = {
    subnet_name = "subnet_http"
    cidr        = "192.168.1.0/24"
  }
}

# Set number of instance
variable "http_instance_names" {
  type    = set(string)
  default = ["instance-http-1", "instance-http-2"]
}

#### DB PARAMS
variable "network_db" {
  type = map(string)
  default = {
    subnet_name = "subnet_db"
    cidr        = "192.168.2.0/24"
  }
}

# Set number of instance
variable "db_instance_names" {
  type    = set(string)
  default = ["instance-db-1", "instance-db-2", "instance-db-3"]
}

# Set number of instance
variable "public_key" {
  type    = string
  description = "SSH public key to login into EC2 instance"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDilZCHi9yQiPsGti/M4FWnerkRwPO1X8fVN9iI9jJn5yOM9kBAx5LGOTnbrO6WYjIjpEmQuQT0GK1ZAr3M+rSURLDI/DMGznM1pijVEVRqf6PLAsZGlghdlC1QN6wVtSYS1LtQ5ISagEZi1OGCRa4m89OiarruuSgFPs7+08kJqwXU1RuCKEJyXldCRwuggZ6M9eY5Rx6XIU9re4WAo5WbnxCb4YOTxZtWa10hVIEoFhrMaExzk7IoBFn8qfjabiWST+K4GVRDhbOy+mfWHpxBEkuWqK4hIvMfmc8wWX7hd+g7hOYhYG+udZ/HxjGs+kLv/gtWGH8+rydqeGMUwniNQpocIAAcTb4uXlaE9Y+PkkR2GuxYlkhxrhltsSjsVqPbfDOgCvANpAZKpqfDka+1kzmwVuJ9lA2gq32sEJYJonmvPB5/HlREAq9kzq4d4g6wLNW2sIDxTg+cU/0DvJxKfkBV6tUBcQEF13gMtJEqFTCySryrq0hB4kuzxn+o0+0= ubuntu@vmi1602561.contaboserver.net
"
}

variable "public_key_name" {
  type    = string
  description = "SSH public key name "
  default = "main-key"
}

variable "env" {
  type = string
  default = "production"
}
