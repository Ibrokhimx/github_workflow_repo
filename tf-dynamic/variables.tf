variable "subnets" {
  type = map(object({
    cidr_block = string
  }))
  default = {}
}

variable "vpc_cidr" {
  type = string
}

variable "security_groups" {
  description = "A map of security groups with their rules"
  type = map(object({
    description = string
    ingress_rules = optional(list(object({
      description = optional(string)
      priority    = number
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })))
    egress_rules = optional(list(object({
      description = optional(string)
      priority    = optional(number)
      from_port   = optional(number)
      to_port     = optional(number)
      protocol    = optional(string)
      cidr_blocks = optional(list(string))
    })))
  }))
}