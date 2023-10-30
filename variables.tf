variable "image_id" {
  description = "This variable contains image id"
  type        = string
  #default     = "ami-09d95fab7fff3776c"
}

variable "instance_type" {
    type = string
    description = "This is my instanc type"
}


variable "key_name" {
    type = string
    description = "Name of ssh key"
}

variable "region" {
    description = "Region"
    type = string
    default = "us-east-1"
  
}

variable "availability_zone" {
    description = "Availability Zone"
    type = string
    default = "us-east-1a"
  
}
variable "vpc_id" {
  description = "VPC ID"
  default = ""
  
}