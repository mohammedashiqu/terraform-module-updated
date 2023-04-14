## Common Variable
variable "customer_id" {}
variable "region" {}
variable "region_code" {}
variable "environment" {}
variable "managed_by" {}

## subnet group configuration
variable "database_subnet_group_name" {}
variable "subnet-1" {}
variable "subnet-2" {}

## data base settings
variable "db_name" {}
variable "allocate_storage" {}
variable "engine" {}
variable "engine_version" {}
variable "multi_az" {}
variable "instance_class" {}
variable "admin_username" {}
variable "admin_password" {}
variable "parameter_group_name" {}
variable "final_snapshot" {}
variable "db_vpc" {}
