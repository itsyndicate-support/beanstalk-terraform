# Define ssh to config in instance

# Create default ssh publique key
resource "aws_key_pair" "user_key" {
  key_name   ="${var.environment_name}-key"
  public_key = var.public_key
}

