##########################################################################
############# Locals for VPC
##########################################################################

locals {
  use2a       = "us-east-2"
  vpc_cidr    = "10.50.0.0/16"
  env         = "qa"
  provisioner = "terraform"
}

##########################################################################
############# Locals for subnets
##########################################################################

locals {
  public-subnets = {
    "public-subnet-1" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 8, 1)
      azs        = "us-east-2a"
      tags = {
        Name         = "${local.env}-pub-sub-1"
        Envinonment  = local.env
        Provisionner = local.provisioner
      }
    }
    "public-subnet-2" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 8, 2)
      azs        = "us-east-2b"
      tags = {
        Name         = "${local.env}-pub-sub-3"
        Envinonment  = local.env
        Provisionner = local.provisioner
      }
    }
    "public-subnet-3" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 8, 3)
      azs        = "us-east-2c"
      tags = {
        Name         = "${local.env}-pub-sub-3"
        Envinonment  = local.env
        Provisionner = local.provisioner
      }
    }
  }

  private-subnets = {
    "private-subnet-1" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 8, 10)
      azs        = "us-east-2a"
      tags = {
        Name         = "${local.env}-priv-sub-1"
        Envinonment  = local.env
        Provisionner = local.provisioner
      }
    }
    "private-subnet-2" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 8, 11)
      azs        = "us-east-2b"
      tags = {
        Name         = "${local.env}-priv-sub-3"
        Envinonment  = local.env
        Provisionner = local.provisioner
      }
    }
    "private-subnet-3" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 8, 12)
      azs        = "us-east-2c"
      tags = {
        Name         = "${local.env}-priv-sub-3"
        Envinonment  = local.env
        Provisionner = local.provisioner
      }
    }
  }

  public_subnet_name = "public-subnet-1"
}

##########################################################################
############# Locals for Public Security Groups
##########################################################################

locals {
  public_sg_ingress = {
    "all-http-ipv4" = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all HTTP IPv4 inbound traffic"
    }
    "all-https-ipv4" = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all HTTPS IPv4 inbound traffic"
    }
  }
  public_sg_egress = {
    "all-traffic-ipv4" = {
      #   from_port   = 0
      #   to_port     = 0
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "-1"
      description = "Allow all IPv4 outbound traffic"
    }
  }
}

##########################################################################
############# Locals for Private Security Group
##########################################################################

locals {
  private_sg_ingress = {
    "all-http" = {
      referenced_security_group_id = module.staging.public_sg_id
      from_port                    = 80
      to_port                      = 80
      ip_protocol                  = "tcp"
      description                  = "Allow all HTTP IPv4 and IPv6 inbound traffic from Public Security Group"
    }
    "all-https" = {
      referenced_security_group_id = module.staging.public_sg_id
      from_port                    = 443
      to_port                      = 443
      ip_protocol                  = "tcp"
      description                  = "Allow all HTTPS IPv4 and IPv6 inbound traffic from Public Security Group"
    }
    "ssh-traffic" = {
      referenced_security_group_id = module.staging.bastion_sg_id
      from_port                    = 22
      to_port                      = 22
      ip_protocol                  = "tcp"
      description                  = "Allow all SSH inbound traffic from Public Security Group"
    }
  }

  private_sg_egress = {
    "all-traffic-ipv4" = {
      #   from_port   = 0
      #   to_port     = 0  
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all IPv4 outbound traffic"
    }
  }
}

##########################################################################
############# Locals for Bastion Security Group
##########################################################################

locals {
  bastion_sg_ingress = {
    "all-ssh-ipv4" = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow SSH IPv4 inbound traffic from anywhere"
    }
  }

  bastion_sg_egress = {
    "all-traffic-ipv4" = {
      #   from_port   = 0
      #   to_port     = 0  
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all IPv4 outbound traffic"
    }

    #  "ssh-traffic" = {
    #     referenced_security_group_id = module.aws_security_group.private_sg.id   
    #     from_port = 22
    #     to_port = 22
    #     ip_protocol = "tcp"
    #     description = "Allow all SSH inbound traffic to Private Security Group"
    # }
  }
}

##########################################################################
############# Locals for Route Tables
##########################################################################

locals {
  all_ipv4_cidr = "0.0.0.0/0"
}

##########################################################################
############# Locals Autoscaling Group
##########################################################################

locals {
  image_id                             = "ami-085f9c64a9b75eed5"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  key_pairs_name                       = "main-us-east-2"
  resource_type                        = "instance"
  user_data                            = filebase64("web.sh")

  desired_capacity          = 2
  max_size                  = 4
  min_size                  = 1
  health_check_grace_period = 10
  health_check_type         = "ELB"
}

##########################################################################
############# Locals for Target Group and Load balancer
##########################################################################

locals {
  lb_proto_http      = "HTTP"
  load_balancer_type = "application"
  lb_proto_https     = "HTTPS"
  lb_port_http       = "80"
  lb_port_https      = "443"
  lb_ssl_policy      = "ELBSecurityPolicy-2016-08"
}

##########################################################################
############# Locals for DNS records
##########################################################################

locals {
  dns_aliases = {
    "alias1" = "www.${local.env}.johnylabs.com"
    "alias2" = "${local.env}.johnylabs.com"
  }

  zone_id         = data.aws_route53_zone.johnylabs_zone.id
  certificate_arn = data.aws_acm_certificate.amazon_issued.arn
}