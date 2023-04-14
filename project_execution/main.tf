####################
## VPC module
####################
module "vpc" {
  source = "../vpc_subnet"
  customer_id = var.customer_id
  region = var.region
  region_code = var.region_code
  environment = var.environment
  managed_by = var.managed_by
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  public_availability_zone = var.public_availability_zone
  private_subnet_cidr = var.private_subnet_cidr
  private_availability_zone = var.private_availability_zone
  eip_count = var.eip_count
  nat_count = var.nat_count
  public_route_table_asso_count = var.public_route_table_asso_count
  private_route_table_asso_count = var.private_route_table_asso_count
  private_route_table_count = var.private_route_table_count
  private_route_table_route_count = var.private_route_table_route_count
}
####################
## EKS module
####################
module "eks" {
  source = "../eks"
  customer_id = var.customer_id
  region = var.region
  region_code = var.region_code
  environment = var.environment
  managed_by = var.managed_by
  eks_cluster_name = var.eks_cluster_name
  subnet_id_1 = module.vpc.private_subnet_id[0]
  subnet_id_2 = module.vpc.private_subnet_id[1]
  node_group_name = var.node_group_name
  eks_node_instance_types = var.eks_node_instance_types
  /*
  prefix_name = var.prefix_name
  image_id = var.image_id
  */
}
####################
## RDS module
####################
module "rds" {
  source = "../rds"
  customer_id = var.customer_id
  region = var.region
  region_code = var.region_code
  environment = var.environment
  managed_by = var.managed_by
  database_subnet_group_name = var.database_subnet_group_name
  subnet-1 = module.vpc.private_subnet_id[0]
  subnet-2 = module.vpc.private_subnet_id[1]
  db_name = var.db_name
  allocate_storage = var.allocate_storage
  engine = var.engine
  engine_version = var.engine_version
  multi_az = var.multi_az
  instance_class = var.instance_class
  admin_username = var.admin_username
  admin_password = var.admin_password
  parameter_group_name = var.parameter_group_name
  final_snapshot = var.final_snapshot
  db_vpc = module.vpc.vpc_id
}