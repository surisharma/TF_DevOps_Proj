variable "db_subnet_group_name" {}
variable "subnet_groups" {}
variable "mysql_dbname" {}
variable "mysql_username" {}
variable "mysql_password" {}
variable "mysql_db_identifier" {}
variable "rds_mysql_sg_id" {}
### RDS Subnet Group
resource "aws_db_subnet_group" "dev_proj_1_db_subnet_group" {
     name = var.db_subnet_group_name
     subnet_ids = var.subnet_groups
}



resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  db_name              = var.mysql_dbname
  engine               = "mysql"
  engine_version       = "8.0"
  identifier           =  var.mysql_db_identifier
  instance_class       = "db.t3.micro"
  username             = var.mysql_username
  password             = var.mysql_password
  vpc_security_group_ids = [var.rds_mysql_sg_id]
  db_subnet_group_name  = aws_db_subnet_group.dev_proj_1_db_subnet_group.name
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot     = true
  apply_immediately       = true
  backup_retention_period = 0
  deletion_protection     = false
}
