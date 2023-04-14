## common variable
variable "customer_id" {}
variable "region" {}
variable "region_code" {}
variable "environment" {}
variable "managed_by" {}

## EKS cluster info
variable "eks_cluster_name" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}

## worker node template
/*
variable "prefix_name" {}
variable "image_id" {}
*/
## worker node
variable "node_group_name" {}
variable "eks_node_instance_types" {}