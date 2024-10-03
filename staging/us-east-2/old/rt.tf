##########################################################################
##### Create Public Route Table along with its subnets associations
##########################################################################

resource "aws_route_table" "staging_public_rt" {
  vpc_id = aws_vpc.staging_vpc.id

  route {
    cidr_block = var.rt_cdr-block
    gateway_id = aws_internet_gateway.staging_igw.id
  }

  tags = {
    Name         = "${var.environment}-${var.public_rt_name}"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

############## Public Route Table assciation with publics subnets

resource "aws_route_table_association" "staging_public_rt_association_1" {
  subnet_id      = aws_subnet.staging_public_subnet1.id
  route_table_id = aws_route_table.staging_public_rt.id
}

resource "aws_route_table_association" "staging_public_rt_association_2" {
  subnet_id      = aws_subnet.staging_public_subnet2.id
  route_table_id = aws_route_table.staging_public_rt.id
}

##########################################################################
##### Create Private Route Table along with its subnets associations
##########################################################################

resource "aws_route_table" "staging_private_rt" {
  vpc_id = aws_vpc.staging_vpc.id

  route {
    cidr_block = var.rt_cdr-block
    gateway_id = aws_nat_gateway.staging_ngw.id
  }

  tags = {
    Name         = "${var.environment}-${var.private_rt_name}"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

############## Private Route Table assciations with publics subnets

resource "aws_route_table_association" "staging_private_rt_association_1" {
  subnet_id      = aws_subnet.staging_private_subnet1.id
  route_table_id = aws_route_table.staging_private_rt.id
}

resource "aws_route_table_association" "staging_private_rt_association_2" {
  subnet_id      = aws_subnet.staging_private_subnet2.id
  route_table_id = aws_route_table.staging_private_rt.id
}

resource "aws_route_table_association" "staging_private_rt_association_3" {
  subnet_id      = aws_subnet.staging_db_subnet1.id
  route_table_id = aws_route_table.staging_private_rt.id
}

resource "aws_route_table_association" "staging_private_rt_association_4" {
  subnet_id      = aws_subnet.staging_db_subnet2.id
  route_table_id = aws_route_table.staging_private_rt.id
}