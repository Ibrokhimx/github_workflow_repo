provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ec2labhomework"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ec2labhomework"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true # To ensure the instance gets a public IP

  tags = {
    Name = "ec2labhomework"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "ec2labhomework"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}

module "security_groups" {
  source          = "./modules/security_groups"
  security_groups = var.security_groups
  vpc_id          = aws_vpc.main.id
}

resource "aws_instance" "main" {
  ami           = "ami-0df435f331839b2d6"
  instance_type = "t2.micro"
  key_name      = "ec2labhomework"

  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [module.security_groups.security_group_id["web_sg"]]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd.service
              sudo systemctl enable httpd.service
              sudo echo "<h1> At $(hostname -f) </h1>" > /var/www/html/index.html                   
              EOF 

  tags = {
    Name = "ec2labhomework"
  }
}

output "security_group_id" {
  value = module.security_groups.security_group_id
}