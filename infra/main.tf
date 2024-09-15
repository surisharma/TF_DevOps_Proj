module "networking" {
   source             = "./networking"
   vpc_cidr           = var.vpc_cidr
   vpc_name           = var.vpc_name
   cidr_public_subnet = var.cidr_public_subnet
   cidr_private_subnet = var.cidr_private_subnet
   us_availability_zone = var.us_availability_zone
}
module "security_group" {
   source = "./security-groups"
   ec2_sg_name = "SG for EC2 to enable SSH(22) and HTTP(80)"
   ec2_sg_name_for_python_api = "SG for EC2 for enabling port 5000"
   vpc_id = module.networking.dev_proj_1_vpc_id
   public_subnet_cidr_block = tolist(module.networking.public_subnet_cidr_block)
}
module "ec2" {
   source = "./ec2"
   ami_id = var.ec2_ami_id
   instance_type = var.instance_type
   tag_name  = "Ubuntu Linux EC2"
   public_key = var.public_key
   subnet_id  = tolist(module.networking.dev_proj_1_public_subnets)[0]
   sg_enable_ssh_https = module.security_group.sg_ec2_sg_ssh_http_id
   enable_public_ip_address = true 
   user_data_install_apache = templatefile("${path.module}/template/ec2_install_apache.sh", {})
   ec2_sg_name_for_python_api = module.security_group.sg_ec2_for_python_api
}
 module "lb-target" {
   source = "./load-balancer-target-group"
   lb_target_group_name     = "dev-proj-1-lb-target-group"
   lb_target_group_port     =  5000
   lb_target_group_protocol =  "HTTP"
   vpc_id                   =   module.networking.dev_proj_1_vpc_id
   ec2_instance_id          =   module.ec2.dev_proj_1_ec2_instance_id

 }
 module "aws_ceritification_manager" {
  source         = "./certificate-manager"
  domain_name    = var.domain_name
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}

module "load_balancer" {
   source               = "./load-balancer"
   lb_name              = "dev-proj-1-alb"
   lb_type              = var.lb_type
   is_external          = false
   sg_enable_ssh_https  = module.security_group.sg_ec2_sg_ssh_http_id
   subnet_ids           = tolist(module.networking.dev_proj_1_public_subnets)
   ec2_instance_id      = module.ec2.dev_proj_1_ec2_instance_id
   lb_target_group_arn  = module.lb-target.dev_proj_1_lb_target_group_arn
   lb_target_group_attachment_port = 5000
   lb_listner_port                =  5000
   lb_listner_protocol            = "HTTP"
   lb_listner_default_action      = "forward"
   lb_https_listner_port          = 443
   lb_https_listner_protocol       = "HTTPS"
   dev_proj_1_acm_arn              = module.aws_ceritification_manager.dev_proj_1_acm_arn
}

module "hosted_zone" {
   source             = "./hosted-zone"
   domain_name        = var.domain_name
   aws_lb_dns_name    = module.load_balancer.aws_lb_dns_name
   aws_lb_zone_id     =  module.load_balancer.aws_lb_zone_id
    
}
module "rds_db_instance" {
   source                = "./rds"
   mysql_dbname          = "devprojdb"
   db_subnet_group_name  = "dev_proj_1_rds_subnet_group"
   subnet_groups         = tolist(module.networking.dev_proj_1_private_subnets)
   rds_mysql_sg_id       = module.security_group.rds_mysql_sg_id
   mysql_db_identifier  = "mydb"
   mysql_username       = local.secret["mysql_username"]
   mysql_password       = local.secret["mysql_password"]
   
}
data "aws_secretsmanager_secret_version" "mysecret" {
    secret_id = "my-database-secret"  
}
locals {
  secret = jsondecode(data.aws_secretsmanager_secret_version.mysecret.secret_string)
}