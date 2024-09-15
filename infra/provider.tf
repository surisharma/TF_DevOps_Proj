provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["c://Users//surin//.aws/credentials"]
}

/*data "aws_secretsmanager_secret_version" "mysecret" {
    secret_id = "my-database-secret"  
}
locals {
  secret = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)
}*/