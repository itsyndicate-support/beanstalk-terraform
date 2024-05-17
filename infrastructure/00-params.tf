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
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDEjtX8rmcAQKzATXJWSaf64Cof31DX+1ZjlaeLz31KDubxjrBao2pj/eg4P6RMiuu2Q9WCtDEsvtb46uWLy7eYq0hM8B60oSmwlU788+KhzdJOxTj8seTppr1p5wlDKTxn5p9pmsESnLI/9Bm0B6O1jfTkYX3anK4VxRFYupHicyWFB0Z9/+Pgh+jblTJ9168vDjkBiexRgcBLq6pCKikV2vMzBdW4oj3Xi8su+q4/sAXzszxTD8DExIqTYY1hpyNXMgJDXXOZIA0Mdd269N6xCGVqxuBX+QYnI0tF84yGU7MjJ6tYW8aN3U9/yGJGlbtDRBbrh5X56xhGnawFBuUYa0mk8eHjmGMfhHj6u5qIzmJWuNKV3R7LX/y7V4Zf0e2NVp2XaQV617JINf7PzMKjicvUM92SuMvc+KwnODVcB941Yz+/U2gZNxbgseytIUBcjNV5Rbm4IKVzHrGdB2/lgqcclVL3ZisKGFD0kG7eET6TtaXwFgas6TXnvwBDkJyXjwyJ7aEAmiHlmEK5ngYFPW4MttmF1nTyHnxu1uKKrH8F920W09CgEgNLL3CuBFnFVMiKYdAMV0ZYQKRUqZ39Xk2LUv1ookfnJ8WNDq7Zu0+RyxglTFl2eDAyNWGW4XRVRq/VkxkQwkXXnJ1hc5RuxYyb4BGc2JnhmaiPA+6Q9w== dendov555@gmail.com"
}

