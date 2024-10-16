# Security group configuration

# Default administration port
#tfsec:ignore:aws-vpc-no-public-ingress-sg
#tfsec:ignore:aws-vpc-no-public-egress-sg
resource "aws_security_group" "administration" {
  name        = "${var.environment_name}-administration"
  description = "Allow default administration service"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "${var.environment_name}-administration"
  }

  # Open ssh port
  ingress {
    description = "Access to vty via ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow icmp
  ingress {
    description = "Allow 8-type ICMP"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open access to public network
  egress {
    description = "Allow access to the Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Open web port
#tfsec:ignore:aws-vpc-no-public-ingress-sg
#tfsec:ignore:aws-vpc-no-public-egress-sg
resource "aws_security_group" "web" {
  name        = "${var.environment_name}-web"
  description = "Allow web incgress trafic"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "${var.environment_name}-web"
  }

  # http port
  ingress {
    description = "Allow HTTP requests"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # https port
  ingress {
    description = "Allow HTTPS requests"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open access to public network
  egress {
    description = "Allow access to the Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Open database port
#tfsec:ignore:aws-vpc-no-public-ingress-sg
#tfsec:ignore:aws-vpc-no-public-egress-sg
resource "aws_security_group" "db" {
  name        = "${var.environment_name}-db"
  description = "Allow db incgress trafic"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "${var.environment_name}-db"
  }

  # db port
  ingress {
    description = "Allow communications between httpd instances & db"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open access to public network
  egress {
    description = "Allow access to the Internet"
    to_port     = 0
    from_port = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

