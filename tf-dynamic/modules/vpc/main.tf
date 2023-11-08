resource "aws_vpc" "dynamic" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = join("-", [var.prefix, "vpc"])
  }
}

variable "prefix" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

output "dynamics_vpc_id" {
  value = aws_vpc.dynamic.id
}