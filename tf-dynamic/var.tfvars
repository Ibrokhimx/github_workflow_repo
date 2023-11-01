vpc_cidr = "10.0.0.0/16"
security_groups = {
  "web_sg" : {
    description = "Security group for web servers"
    ingress_rules = [
      {
        description = "ingress rule for http"
        priority    = 200
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        priority    = 201
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        priority    = 502
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        priority    = 503
        from_port   = 53
        to_port     = 53
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  "app_sg" : {
    description = "Security group for application servers"
    ingress_rules = [
      {
        priority    = 203
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    # egress_rules = [
    #   {
    #     priority    = 501
    #     from_port   = 0
    #     to_port     = 65535
    #     protocol    = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    #   }
    # ]
  }
}  