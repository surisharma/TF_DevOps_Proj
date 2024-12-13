name        = "environment"
environment = "dev-1"
lb_type = "application"

vpc_cidr             = "11.0.0.0/16"
vpc_name             = "dev-proj-eu-central-1-vpc-1"
cidr_public_subnet   = ["11.0.1.0/24", "11.0.2.0/24"]
cidr_private_subnet  = ["11.0.3.0/24", "11.0.4.0/24"]
us_availability_zone = ["eu-central-1a", "eu-central-1b"]

public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINsDl775nJAUJC8r8TKcOV/KVRkGUswA+9P5MaQPzeLu"

ec2_ami_id = "ami-0a628e1e89aaedf80"
instance_type = "t2.meduim"

ec2_user_data_install_apache = ""

domain_name = "lalitbainsla.co.in"
