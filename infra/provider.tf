provider "aws" {
  region                   = "eu-central-1"
  shared_credentials_files = ["c://Users//surin//.aws/credentials"]
}
terraform {
  backend "s3" {
    bucket = "suritest123"
    key    = "devops-project-1-terraform.tfstate"
    region = "eu-central-1"
  }
}

/*data "aws_secretsmanager_secret_version" "mysecret" {
    secret_id = "my-database-secret"  
}
locals {
  secret = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)
}*/
