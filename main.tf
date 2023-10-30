resource "aws_instance" "example" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id, aws_security_group.ssh.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd.service
              sudo systemctl enable httpd.service
              sudo echo "<h1> At $(hostname -f) </h1>" > /var/www/html/index.html                   
              EOF
  tags = {
    Name = "terraform-example"
  }
  key_name = var.key_name
}
resource "aws_key_pair" "my_key_pair" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_ed25519.pub")
}
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name = "terraform-ssh-instance"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_vpc" "web" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "web"
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.web.id
  #sensitive = true
}
 
output "public_ip" {
  description = "IP of Example EC2" 
  value = aws_instance.example.public_ip
  
}