###########################
## defined common variables
###########################
locals {
  prefix = "BF-${var.customer_id}-${var.environment}-${var.region_code}"
}
#########################
## defined eks iam role
#########################
resource "aws_iam_role" "eks_iam_role" {
 name               = "eks_iam_role"
 path               = "/"
 assume_role_policy = file("eks_iam_role.json")
 tags = {
  Name       = "${local.prefix}-IRE-01"
  Region     = var.region
  Env        = var.environment
  Created_on = timestamp()
  Managed_by = var.managed_by
  Resource   = "ROLE"
 }
}
#############################################
## defined eks cluster policy+role attachment
#############################################
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role       = aws_iam_role.eks_iam_role.name
}
###################################################
## defined eks ECR read only policy+role attachment
###################################################
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role       = aws_iam_role.eks_iam_role.name
}
#############################
## defined eks cluster
#############################
resource "aws_eks_cluster" "eks_cluster" {
 name        = var.eks_cluster_name
 role_arn    = aws_iam_role.eks_iam_role.arn
 tags = {
  Name       = "${local.prefix}-EKS-01"
  Region     = var.region
  Env        = var.environment
  Created_on = timestamp()
  Managed_by = var.managed_by
  Resource   = "EKS"
 }
 vpc_config {
  subnet_ids = [var.subnet_id_1, var.subnet_id_2]
 }
 depends_on  = [aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
                aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
                aws_iam_role.eks_iam_role]
  lifecycle {
   ignore_changes = all
  }
}

###############################
## defined worker node iam role
###############################
resource "aws_iam_role" "workernodes" {
  name               = "eks_node_iam_role"
  assume_role_policy = file("eks_node_role.json")
  tags = {
   Name       = "${local.prefix}-IRW-01"
   Region     = var.region
   Env        = var.environment
   Created_on = timestamp()
   Managed_by = var.managed_by
   Resource   = "ROLE"
 }
 }
############################################
## defined node group policy+role attachment
############################################
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.workernodes.name
 }
############################################
## defined node group policy+role attachment
############################################
 resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.workernodes.name
 }
############################################
## defined node group policy+role attachment
############################################
 resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role       = aws_iam_role.workernodes.name
 }
############################################
## defined node group policy+role attachment
############################################
 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.workernodes.name
 }
############################################
## defined node group template
############################################
/*resource "aws_launch_template" "node_group_template" {
  name_prefix = var.prefix_name
  image_id    = var.image_id

  tags = {
   Name       = "${local.prefix}-EC2-01"
   Region     = var.region
   Env        = var.environment
   Created_on = timestamp()
   Managed_by = var.managed_by
   Resource   = "EC2"
  }
}*/
###########################################
## defined eks node group
###########################################
 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.workernodes.arn
  subnet_ids      = [var.subnet_id_1, var.subnet_id_2]
  instance_types  = var.eks_node_instance_types
  tags = {
   Name = "${local.prefix}-ENG-01"
   Region     = var.region
   Env        = var.environment
   Created_on = timestamp()
   Managed_by = var.managed_by
   Resource   = "Node Group"
  }
 /*
 launch_template {
   id = aws_launch_template.node_group_template.id
   version = 1
  }
*/
  scaling_config {
   desired_size = 2
   max_size     = 3
   min_size     = 2
  }
   /*lifecycle {
    ignore_changes = all
  }*/
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.EC2InstanceProfileForImageBuilderECRContainerBuilds,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]
 }


