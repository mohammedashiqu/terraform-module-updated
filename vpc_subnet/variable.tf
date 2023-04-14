## Common Variable
variable "customer_id" {}
variable "region" {}
variable "region_code" {}
variable "environment" {}
variable "managed_by" {}

## VPC Variable
variable "vpc_cidr" {}

## Public Subnet Variable
variable "public_subnet_cidr" {}
variable "public_availability_zone" {}

## Private Subnet Variable
variable "private_subnet_cidr" {}
variable "private_availability_zone" {}

## EIP Variable
variable "eip_count" {}

## NAT Gateway Variable
variable "nat_count" {}

## Defining Public Route Table Association
variable "public_route_table_asso_count" {}

## Defining Private Route Table Association
variable "private_route_table_asso_count" {}

## Defining Private Route Tabl
variable "private_route_table_count" {}

## Defining Private Route Table Route Iteration Count
variable "private_route_table_route_count" {}

