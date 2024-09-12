name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-us-east-1-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
us_availability_zone = ["us-east-1a", "us-east-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoE/zqmrmMbncftvHKy4H+q0KGRsMVfzThk8XlRQuNYMd4VW9MzVPhJRRGoTeovX4yfL74JR/ZQnvIh7XNO6khK1qZhvkd1WFJCeHnQfwki3Fc7jbiJs6S7VAwMWCAZgkgx4CV/Ubd7IS+D4CRlstiH3IjZgPvGINFxwHrAMVtM1oLduNVIh6o+xJFLrh11PnpEKMcIE+Xn8G0/gpAIh62H+tuq18To/dRZAj7q9hlg/UpmV5vVW2t+8mYVD0VmpBd/DEeuMN3Lkew4k1jwIETXD8vvx34RKlTGJqtmS3tPyFWYXZ6CI305j5AVLTwjGaIvH+D3Li3ttuuSuD5IVDU+Dkqb7jJUSLTuOZ5QapqT8gyCP6D1FmiGixV8ywoYhAml5h+sk79/oU6l5nfe2hL5W2sbZBimwoPtWiO1OIwGtdKWcbj7r7zbzhlnaLaEPqIaXKr5kWJFNEUqPyGz/yMVentn6LaNkSTC+8QpsX4QDkgalP++DYE3RDTXFg3WYk="

ec2_ami_id = "ami-0e86e20dae9224db8"
instance_type = "t2.micro"

ec2_user_data_install_apache = ""

domain_name = "exampel.org"
