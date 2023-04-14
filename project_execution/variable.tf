###########################
## defined common variables
###########################
variable "provider_version" {
  description = "provider relevant version"
  type = string
  default = null
}
variable "customer_id" {
  description = "project client id/customerid for identification"
  type = string
  default = null
}
variable "region" {
  description = "infrastructure region name"
  type = string
  default = null
}
variable "region_code" {
  description = "region short code for tags"
  type = string
  default = null
}
variable "environment" {
  description = "environments for tag"
  type = string
  default = null
}
variable "managed_by" {
  description = "project management team"
  type = string
  default = null
}
#---------------------------------------------------------------------------------
#########################
## defined vpc variable
#########################
variable "vpc_cidr" {
  description = "vpc cidr range"
  type = string
  default = null
}
variable "public_subnet_cidr" {
  description = "public subnet cidr"
  type = list(string)
  default = null
}
variable "public_availability_zone" {
  description = "public availability zone"
  type = list(string)
  default = null
}
variable "private_subnet_cidr" {
  description = "private cidr"
  type = list(string)
  default = null
}
variable "private_availability_zone" {
  description = "private availability zone"
  type = list(string)
  default = null
}
variable "eip_count" {
  description = "elastic ip count"
  type = number
  default = null
}
variable "nat_count" {
  description = "nat gateway count"
  type = number
  default = null
}
variable "public_route_table_asso_count" {
  description = "public route table asscociation count"
  type = number
  default = null
}
variable "private_route_table_asso_count" {
  description = "private route table association count"
  type = number
  default = null
}
variable "private_route_table_count" {
  description = "private route table count"
  type = number
  default = null
}
variable "private_route_table_route_count" {
  description = "number of time route table iteration for route(it will depend how many route table you have)"
}
#---------------------------------------------------------------------------------
#########################
## defined eks variable
#########################
variable "eks_cluster_name" {
  description = "eks cluster name"
  type = string
  default = null
}
variable "subnet_id_1" {
  description = "subnet-id"
  default = null
}
variable "subnet_id_2" {
  description = "subnet-id"
  default = null
}
/*
variable "prefix_name" {
  description = "prefix name of node group template"
  type = string
  default = null
}
variable "image_id" {
  description = "node os image id/AMI"
  type = string
  default = null
}
*/
variable "node_group_name" {
  description = "eks node group name"
  type = string
  default = null
}
variable "eks_node_instance_types" {
  description = "this is node group instnace capacity"
  type = list(string)
  default = null
}
#########################
## defined rds variable
#########################
variable "database_subnet_group_name" {
  description = "database subneet group name"
  type = string
  default = null
}
variable "subnet-1" {
  description = "subnet-1 id"
  default = null
}
variable "subnet-2" {
  description = "subnet-2 id"
  default = null
}
## data base settings
variable "db_name" {
  description = "database name"
  type = string
  default = null
}
variable "allocate_storage" {
  description = "db allocated storage"
  type = number
  default = null
}
variable "engine" {
  description = "database engine name"
  type = string
  default = null
}
variable "engine_version" {
  description = "database engine version"
  type = string
  default = null
}
variable "multi_az" {
  description = "multi_az"
  type = bool
  default = null
}
variable "instance_class" {
  description = "instnace class"
  type = string
  default = null
}
variable "admin_username" {
  description = "admin_username"
  type = string
  default = null
}
variable "admin_password" {
  description = "admin_paassword"
  type = string
  default = null
}
variable "parameter_group_name" {
  description = "parameter group name"
  type = string
  default = null
}
variable "final_snapshot" {
  description = "final snapshot required or not"
  type = bool
  default = null
}
variable "db_vpc" {
  description = "db security grooup"
  default = null
}
