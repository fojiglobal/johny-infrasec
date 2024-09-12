##########################################################################
##### Create a VPC ressouve with cidr block "10.30.0.0/16"
##########################################################################

resource "aws_vpc" "staging_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name         = "${var.environment}-vpc"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
####### Create Internet Gateway
##########################################################################

resource "aws_internet_gateway" "staging_igw" {
  vpc_id = aws_vpc.staging_vpc.id

  tags = {
    Name         = "${var.environment}-igw"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
####### Create Nat Gateway
##########################################################################

resource "aws_nat_gateway" "staging_ngw" {
  # connectivity_type = public
  allocation_id = aws_eip.staging_eip.allocation_id
  # public_ip = aws_eip.staging_eip.public_ip
  subnet_id = aws_subnet.staging_public_subnet1.id

  tags = {
    Name         = "${var.environment}-ngw"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.staging_igw]
}

##########################################################################
####### Create Elastic IP for the Nat Gateway
##########################################################################

resource "aws_eip" "staging_eip" {
  domain = "vpc"

  tags = {
    Name         = "${var.environment}-eip"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}