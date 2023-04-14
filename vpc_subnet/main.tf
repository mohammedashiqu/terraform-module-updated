#########################
## defined local variable
#########################
locals {
  prefix = "BF-${var.customer_id}-${var.environment}-${var.region_code}"
}
#########################
## defined vpc
#########################
resource "aws_vpc" "vpc" {
  cidr_block   = var.vpc_cidr
  tags = {
    Name       = "${local.prefix}-VPC-01"
    Region     = var.region
    Env        = var.environment
    Created_on = timestamp()
    Managed_by = var.managed_by
    Resource   = "VPC"
  }/*
  lifecycle {
    ignore_changes = all
  }*/
}
#########################
## defined publoc subnet
#########################
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnet_cidr)
  cidr_block              = var.public_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.public_availability_zone[count.index]
  tags = {
    Name       = "${local.prefix}-PBS-0${count.index + 1}"
    Region     = var.region
    Env        = var.environment
    Created_on = timestamp()
    Managed_by = var.managed_by
    Resource   = "PBS"
  }
}
#########################
## defined private subnet
#########################
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnet_cidr)
  cidr_block              = var.private_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.private_availability_zone[count.index]
  tags = {
    Name       = "${local.prefix}-PVS-0${count.index + 1}"
    Region     = var.region
    Env        = var.environment
    Created_on = timestamp()
    Managed_by = var.managed_by
    Resource   = "PVS"
  }
}
###########################
## defined internet gateway
###########################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name       = "${local.prefix}-IGW-01"
    Region     = var.region
    Env        = var.environment
    Created_on = timestamp()
    Managed_by = var.managed_by
    Resource   = "IGW"
  }
}
#########################
## defined elastic ip
#########################
resource "aws_eip" "eip" {
  count = var.eip_count
  vpc   = true
  tags = {
    Name       = "${local.prefix}-EIP-${count.index + 1}"
    Region     = var.region
    Env        = var.environment
    Created_on = timestamp()
    Managed_by = var.managed_by
    Resource   = "EIP"
  }
}
#########################
## defined nat gateway
#########################
resource "aws_nat_gateway" "ngw" {
  count         = var.nat_count
  subnet_id     = aws_subnet.public_subnet[count.index].id
  allocation_id = aws_eip.eip[count.index].id
  tags = {
    Name       = "${local.prefix}-NAT-0${count.index + 1}"
    Region     = var.region
    Env        = var.environment
    Created_on = timestamp()
    Managed_by = var.managed_by
    Resource   = "NAT"
  }
}
############################
## defined pulic route table
############################
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name       = "${local.prefix}-PBR-01"
    Region     = var.region
    Env        = var.environment
    Created_on = timestamp()
    Managed_by = var.managed_by
    Resource   = "PBR"
  }
}
#########################################
## defined public route table association
#########################################
resource "aws_route_table_association" "pub_sub_pub_rt_asso" {
  count          = var.public_route_table_asso_count
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}
##############################
## defined private route table
##############################
resource "aws_route_table" "private_route_table" {
  count  = var.private_route_table_count
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name       = "${local.prefix}-PVR-0${count.index + 1}"
    Region     = var.region
    Env        = var.environment
    Created_on = timestamp()
    Managed_by = var.managed_by
    Resource   = "PVR"
  }
}
##########################################
## defined private route table association
##########################################
resource "aws_route_table_association" "pvt_sub_pvt_rt_asso" {
  count          = var.private_route_table_asso_count
  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}
####################################
## defined public route table routes
####################################
resource "aws_route" "pub_subnet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
#####################################
## defined private route table routes
#####################################
resource "aws_route" "pvt_subnet_route" {
  count = var.private_route_table_route_count
  route_table_id         = aws_route_table.private_route_table[count.index].id
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}