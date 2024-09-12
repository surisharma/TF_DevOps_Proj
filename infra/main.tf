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
   user_data_install_apache = templatefile("c://Users//ssharma//TF_DevOps_Proj//infra//template//ec2_install_apache.sh", {})
   ec2_sg_name_for_python_api = module.security_group.sg_ec2_for_python_api
}

