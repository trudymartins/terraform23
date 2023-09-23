provider "aws" {
  region = "us-east-1" 
}

resource "aws_lightsail_instance" "example" {
  name              = "example-instance"
  availability_zone = "us-east-1a" # Change this to your desired availability zone
  blueprint_id      = "amazon_linux_2"

  bundle_id = "nano_2_0"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>This Server is created using Terraform</h1>" | sudo tee /var/www/html/index.html
              EOF

  key_pair_name = "your-key-pair-name" # Change this to your SSH key pair name
}

output "public_ip" {
  value = aws_lightsail_instance.example.public_ip_address
}