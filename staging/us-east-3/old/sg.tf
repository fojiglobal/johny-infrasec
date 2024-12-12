##########################################################################
##### Create Public Security Group
##########################################################################

resource "aws_security_group" "staging_public_sg" {
  name        = "${var.environment}-${var.public_sg_name}"
  description = "Allow HTP and HTTPS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.staging_vpc.id

  ############# Ingress rules for Public Security Group ####################

  ingress {
    description      = "Allows HTTP inbound traffic from anywhere IPV4 and IPV6"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.ipv4_cidr_block]
    ipv6_cidr_blocks = [var.ipv6_cidr_block]
  }

  ingress {
    description      = "Allows HTTPS inbound traffic from anywhere IPV4 and IPV6"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.ipv4_cidr_block]
    ipv6_cidr_blocks = [var.ipv6_cidr_block]
  }

  ############# Egress rules for Public Security Group ####################

  egress {
    description      = "Allows all outbound traffic to anywhere IPV4 and IPV6"
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # semantically equivalent to all ports
    cidr_blocks      = [var.ipv4_cidr_block]
    ipv6_cidr_blocks = [var.ipv6_cidr_block]
  }

  tags = {
    Name         = "${var.environment}-${var.public_sg_name}"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }

}

##########################################################################
##### Create Private Security Group
##########################################################################

resource "aws_security_group" "staging_private_sg" {
  name        = "${var.environment}-${var.private_sg_name}"
  description = "Allow HTTP, HTTPS, and SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.staging_vpc.id

  ############# Ingress rules for Private Security Group ####################

  ingress {
    description     = "Allows HTTP inbound traffic from Public Security Group only"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_public_sg.id]
  }

  ingress {
    description     = "Allows HTTPS inbound traffic from Public Security Group only"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_public_sg.id]
  }

  ingress {
    description     = "Allows SSH inbound traffic from Bastion Security Group only"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_bastion_sg.id]
  }

  ############# Egress rules for Private Security Group ####################

  egress {
    description      = "Allows all outbound traffic to anywhere IPV4 and IPV6"
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # semantically equivalent to all ports
    cidr_blocks      = [var.ipv4_cidr_block]
    ipv6_cidr_blocks = [var.ipv6_cidr_block]
  }

  tags = {
    Name         = "${var.environment}-${var.private_sg_name}"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
##### Create Bastion Security Group
##########################################################################

resource "aws_security_group" "staging_bastion_sg" {
  name        = "${var.environment}-${var.bastion_sg_name}"
  description = "Allow SSH inbound traffic and SSH outbound traffic"
  vpc_id      = aws_vpc.staging_vpc.id

  ############# Ingress rules for Bastion Security Group ####################

  ingress {
    description     = "Allows SSH inbound traffic from Public Security Group only"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_public_sg.id]
  }

  ############# Egress rules for Bastion Security Group ####################

  egress {
    description      = "Allows SSH outbound traffic to anywhere IPV4 and IPV6"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ipv4_cidr_block]
    ipv6_cidr_blocks = [var.ipv6_cidr_block]
  }

  tags = {
    Name         = "${var.environment}-${var.bastion_sg_name}"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
##### Create Database Security Group
##########################################################################

resource "aws_security_group" "staging_db_sg" {
  name        = "${var.environment}-${var.db_sg_name}"
  description = "Allow Oracle/RDS, MSSQL, MYSQL/Aurora, PosrgreSQL inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.staging_vpc.id

  ############# Ingress rules for Database Security Group ##################

  ingress {
    description     = "Allows Oracle/RDS inbound traffic from Private Security Group only"
    from_port       = 1521
    to_port         = 1521
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_private_sg.id]
  }

  ingress {
    description     = "Allows MSSQL inbound traffic from Private Security Group only"
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_private_sg.id]
  }

  ingress {
    description     = "Allows MYSQL/Aurora inbound traffic from Private Security Group only"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_private_sg.id]
  }

  ingress {
    description     = "Allows PosrgreSQL inbound traffic from Private Security Group only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_private_sg.id]
  }

  ############# Egress rules for Database Security Group ###################

  #   egress {
  #     description     = "Allows all outbound traffic to anywhere Private Security Group"
  #     from_port       = 0
  #     to_port         = 0
  #     protocol        = "-1"
  #     security_groups = [aws_security_group.staging_private_sg.id]
  #   }

  egress {
    description     = "Allows Oracle/RDS inbound traffic from Private Security Group only"
    from_port       = 1521
    to_port         = 1521
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_private_sg.id]
  }

  egress {
    description     = "Allows MSSQL inbound traffic from Private Security Group only"
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_private_sg.id]
  }

  egress {
    description     = "Allows MYSQL/Aurora inbound traffic from Private Security Group only"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_private_sg.id]
  }

  egress {
    description     = "Allows PosrgreSQL inbound traffic from Private Security Group only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_private_sg.id]
  }

  tags = {
    Name         = "${var.environment}-${var.db_sg_name}"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}
