##### Define the region variable
variable "region" {
  type    = string
  default = "us-east-2"
}

##### Define the VPC cidr block variable
variable "vpc_cidr_block" {
  type    = string
  default = "10.30.0.0/16"
}

##### Define the Environment variable
variable "environment" {
  type    = string
  default = "staging"
}

##### Define the Provisionner Variable 
variable "provisioner" {
  type    = string
  default = "Terraform"
}

##### Define the Public Security Name Variable 
variable "public_sg_name" {
  type    = string
  default = "public-sg"
}

##### Define the Private Security Name Variable 
variable "private_sg_name" {
  type    = string
  default = "private-sg"
}

##### Define the Bastion Security Name Variable 
variable "bastion_sg_name" {
  type    = string
  default = "bastion-sg"
}

##### Define the Bastion Security Name Variable 
variable "db_sg_name" {
  type    = string
  default = "db-sg"
}

##### Define the IPv4 cidr block for ingress and egress rules
variable "ipv4_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

##### Define the IPv6 cidr block for ingress and egress rules
variable "ipv6_cidr_block" {
  type    = string
  default = "::/0"
}

##### Define the Public Subnet Name Variable 
variable "public_subnet_name" {
  type    = string
  default = "public-subnet"
}

##### Define the Private Subnet Name Variable 
variable "private_subnet_name" {
  type    = string
  default = "private-subnet"
}

##### Define the Database Subnet Name Variable 
variable "db_subnet_name" {
  type    = string
  default = "db-subnet"
}

##### Define the Public Subnet 1 cidr block variable
variable "pub_sub1_cidr_block" {
  type    = string
  default = "10.30.10.0/24"
}

##### Define the Public Subnet 2 cidr block variable
variable "pub_sub2_cidr_block" {
  type    = string
  default = "10.30.20.0/24"
}

##### Define the Private Subnet 1 cidr block variable
variable "priv_sub1_cidr_block" {
  type    = string
  default = "10.30.30.0/24"
}

##### Define the Private Subnet 2 cidr block variable
variable "priv_sub2_cidr_block" {
  type    = string
  default = "10.30.40.0/24"
}

##### Define the Database Subnet 1 cidr block variable
variable "db_sub1_cidr_block" {
  type    = string
  default = "10.30.50.0/24"
}

##### Define the Database Subnet 2 cidr block variable
variable "db_sub2_cidr_block" {
  type    = string
  default = "10.30.60.0/24"
}

##### Define the Public Route Table Name Variable 
variable "public_rt_name" {
  type    = string
  default = "public-rt"
}

##### Define the Private Route Table Name Variable 
variable "private_rt_name" {
  type    = string
  default = "private-rt"
}

##### Define the  Route Table cidr block Variable 
variable "rt_cdr-block" {
  type    = string
  default = "0.0.0.0/0"
}