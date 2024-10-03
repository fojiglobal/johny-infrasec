##########################################################################
##### Create a VPC ressouve with cidr block "10.50.0.0/16"
##########################################################################

resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name         = "${var.env}-vpc"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

##########################################################################
############# Create Sunbets ressources 
##########################################################################

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  for_each = var.public_subnets
  cidr_block              = each.value["cidr_block"]
  availability_zone       = each.value["azs"]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = each.value["tags"]
}

resource "aws_subnet" "private_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  for_each = var.private_subnets
  cidr_block              = each.value["cidr_block"]
  availability_zone       = each.value["azs"]
  tags = each.value["tags"]
}

##########################################################################
############# Create Internet Gateway ressource
##########################################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name         = "${var.env}-igw"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

##########################################################################
############# Create Nat Gateway ressource
##########################################################################

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.allocation_id
  subnet_id = aws_subnet.public_subnets[var.public_subnet_name].id
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name         = "${var.env}-ngw"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

##########################################################################
####### Create Elastic IP for the Nat Gateway
##########################################################################

resource "aws_eip" "eip" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name         = "${var.env}-eip"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

##########################################################################
####### Create Public Security Groups ressource
##########################################################################

resource "aws_security_group" "public_sg" {
    name        = "${var.env}-public-sg"
  description = "Allow HTTP and HTTPS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name         = "${var.env}-public-sg"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

################ Public Security Group Ingress Rules ######################

resource "aws_vpc_security_group_ingress_rule" "public_sg_ingress" {
  security_group_id = aws_security_group.public_sg.id
  for_each = var.public_sg_ingress
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  ip_protocol          = each.value["ip_protocol"]
  cidr_ipv4       = each.value["cidr_ipv4"]
  description = each.value["description"]
}

################ Public Security Group Egress Rules ######################

resource "aws_vpc_security_group_egress_rule" "public_sg_egress" {
  security_group_id = aws_security_group.public_sg.id
  for_each = var.public_sg_egress
#   from_port         = each.value["from_port"]
#   to_port           = each.value["to_port"]
  ip_protocol          = each.value["ip_protocol"]
  cidr_ipv4       = each.value["cidr_ipv4"]
  description = each.value["description"]
}

##########################################################################
####### Create Private Security Groups ressource
##########################################################################

################ Private Security Group ###########################
resource "aws_security_group" "private_sg" {
  name        = "${var.env}-private-sg"
  description = "Allow HTTP, HTTPS and SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name         = "${var.env}-private-sg"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

################ Private Security Group Ingress Rules ######################

resource "aws_vpc_security_group_ingress_rule" "private_sg_ingress" {
  security_group_id = aws_security_group.private_sg.id 
  for_each = var.private_sg_ingress
  referenced_security_group_id = each.value["referenced_security_group_id"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  ip_protocol          = each.value["ip_protocol"]
  description = each.value["description"]
}

################ Private Security Group Egress Rules ######################

resource "aws_vpc_security_group_egress_rule" "private_sg_egress" {
  security_group_id = aws_security_group.private_sg.id
  for_each = var.private_sg_egress
#   from_port         = each.value["from_port"]
#   to_port           = each.value["to_port"]
  ip_protocol          = each.value["ip_protocol"]
  cidr_ipv4       = each.value["cidr_ipv4"]
  description = each.value["description"]
}

##########################################################################
####### Create Bastion Security Groups ressource
##########################################################################

################ Bastion Security Group ###########################

resource "aws_security_group" "bastion_sg" {
  name        = "${var.env}-bastion-sg"
  description = "Allow only SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name         = "${var.env}-bastion-sg"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

################ Bastion Security Group Ingress Rules ######################

resource "aws_vpc_security_group_ingress_rule" "bastion_sg_ingress" {
  security_group_id = aws_security_group.bastion_sg.id
  for_each = var.bastion_sg_ingress
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  ip_protocol          = each.value["ip_protocol"]
  cidr_ipv4       = each.value["cidr_ipv4"]
  description = each.value["description"]
}

################ Bastion Security Group Egress Rules ######################

resource "aws_vpc_security_group_egress_rule" "bastion_sg_egress" {
  security_group_id = aws_security_group.bastion_sg.id
  for_each = var.bastion_sg_egress
#   from_port         = each.value["from_port"]
#   to_port           = each.value["to_port"]
  ip_protocol          = each.value["ip_protocol"]
  cidr_ipv4       = each.value["cidr_ipv4"]
  description = each.value["description"]
}

##########################################################################
####### Create Public Route Table ressource
##########################################################################

############# Public Route Table  ##########################

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.all_ipv4_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name         = "${var.env}-public-rt"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

############# Private Route Table  ##########################

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.all_ipv4_cidr
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name         = "${var.env}-private-rt"
    Envinonment  = var.env
    Provisionner = var.provisioner
  }
}

##########################################################################
####### Create Route Table Association 
##########################################################################

############# Public Route Table Associations ##########################

resource "aws_route_table_association" "public_rt_associations" {
  route_table_id = aws_route_table.public_rt.id
  for_each = var.public_subnets
  subnet_id      = aws_subnet.public_subnets[each.key].id
}

############# Private Route Table Associations ##########################

resource "aws_route_table_association" "private_rt_associations" {
  route_table_id = aws_route_table.private_rt.id
  for_each = var.private_subnets
  subnet_id      = aws_subnet.private_subnets[each.key].id
}

##########################################################################
####### Create Launch Template
##########################################################################

resource "aws_launch_template" "lt" {
  name = "${var.env}-lt"
  image_id                             = var.image_id
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  instance_type                        = var.instance_type
  key_name                             = var.key_pairs_name
  vpc_security_group_ids               = [aws_security_group.private_sg.id]
  
  tag_specifications {
    resource_type = var.resource_type

    tags = {
      Name         = "${var.env}-web"
      Envinonment  = var.env
      Provisionner = var.provisioner
    }
  }
  user_data = var.user_data
}

##########################################################################
####### Create Auto Scaling Group
##########################################################################

resource "aws_autoscaling_group" "staging_asg" {
  name = "${var.env}-asg"
#   target_group_arns   = [aws_lb_target_group.staging_tg.arn]
  vpc_zone_identifier = [ for subnet in aws_subnet.private_subnets : subnet.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1

  launch_template {
    id      = aws_launch_template.lt.id
    version = aws_launch_template.lt.latest_version
  }
}