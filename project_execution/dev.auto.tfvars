###################
## common variables
###################
customer_id = "CID"
region = "us-east-2"
region_code = "UE"
environment = "DEV"
managed_by = "BETAFLUX"
##################
## vpc variables
##################
vpc_cidr = "10.0.0.0/24"
public_subnet_cidr = ["10.0.0.0/26","10.0.0.64/26"]
public_availability_zone = ["us-east-2a","us-east-2b"]
private_subnet_cidr = ["10.0.0.128/26","10.0.0.192/26"]
private_availability_zone = ["us-east-2a","us-east-2b"]
eip_count = 2
nat_count = 2
public_route_table_asso_count = 2
private_route_table_asso_count = 2
private_route_table_count = 2
private_route_table_route_count = 2
##################
## EKS variables
##################
eks_cluster_name = "Betaflux_eks_cluster"
node_group_name = "Betaflux_eks_cluste_node"
eks_node_instance_types = ["t2.medium","t2.medium"]
/*
prefix_name = "template"
image_id = "ami-08c2f492722e1d2c6"
*/
##################
## EKS variables
##################
database_subnet_group_name = "main_subnet_group"
## data base settings
db_name = "project"
allocate_storage = 10
engine = "mysql"
engine_version = "5.7"
multi_az = true
instance_class = "db.t3.micro"
admin_username = "admin"
admin_password = "adminadmin"
parameter_group_name = "default.mysql5.7"
final_snapshot = true
