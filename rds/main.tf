#########################
## defined local variable
#########################
locals {
  prefix = "BF-${var.customer_id}-${var.environment}-${var.region_code}"
}
###########################
## defined rds subnet group
###########################
resource "aws_db_subnet_group" "db-subnet" {
  name       = var.database_subnet_group_name
  subnet_ids = [var.subnet-1,var.subnet-2]
  tags = {
   Name = "${local.prefix}-DSG-01"
   Region     = var.region
   Env        = var.environment
   Created_on = timestamp()
   Managed_by = var.managed_by
   Resource   = "RDS"
  }
}
###############################
## defined db instnace settings
###############################
resource "aws_db_instance" "name" {
  allocated_storage    = var.allocate_storage
  name                 = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  multi_az             = var.multi_az
  instance_class       = var.instance_class
  username             = var.admin_username
  password             = var.admin_password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.final_snapshot
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  db_subnet_group_name = aws_db_subnet_group.db-subnet.name
  tags = {
   Name = "${local.prefix}-RDS-01"
   Region     = var.region
   Env        = var.environment
   Created_on = timestamp()
   Managed_by = var.managed_by
   Resource   = "RDS"
  }
  lifecycle {
    ignore_changes = all
  }
}
resource "aws_security_group" "db_security_group" {
  name = "db_sg"
  vpc_id = var.db_vpc
  ingress {
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}