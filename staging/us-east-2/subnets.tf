##########################################################################
##### Create Public Subnet 1
##########################################################################

resource "aws_subnet" "staging_public_subnet1" {
  vpc_id                  = aws_vpc.staging_vpc.id
  cidr_block              = var.pub_sub1_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name         = "${var.environment}-${var.public_subnet_name}-1"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
##### Create Public Subnet 2
##########################################################################

resource "aws_subnet" "staging_public_subnet2" {
  vpc_id                  = aws_vpc.staging_vpc.id
  cidr_block              = var.pub_sub2_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name         = "${var.environment}-${var.public_subnet_name}-2"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
##### Create Private Subnet 1
##########################################################################

resource "aws_subnet" "staging_private_subnet1" {
  vpc_id     = aws_vpc.staging_vpc.id
  cidr_block = var.priv_sub1_cidr_block

  tags = {
    Name         = "${var.environment}-${var.private_subnet_name}-1"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
##### Create Private Subnet 2
##########################################################################

resource "aws_subnet" "staging_private_subnet2" {
  vpc_id     = aws_vpc.staging_vpc.id
  cidr_block = var.priv_sub2_cidr_block

  tags = {
    Name         = "${var.environment}-${var.private_subnet_name}-2"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
##### Create Database Subnet 1
##########################################################################

resource "aws_subnet" "staging_db_subnet1" {
  vpc_id     = aws_vpc.staging_vpc.id
  cidr_block = var.db_sub1_cidr_block

  tags = {
    Name         = "${var.environment}-${var.db_subnet_name}-1"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
##### Create Database Subnet 2
##########################################################################

resource "aws_subnet" "staging_db_subnet2" {
  vpc_id     = aws_vpc.staging_vpc.id
  cidr_block = var.db_sub2_cidr_block

  tags = {
    Name         = "${var.environment}-${var.db_subnet_name}-2"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}