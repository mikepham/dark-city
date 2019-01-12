#------------------------------------------------------------------------------
# Terraform
#------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.11.11"

  backend "s3" {
    bucket = "nativecode"
    key    = "terraform/development/"
    region = "us-east-1"
  }
}

#------------------------------------------------------------------------------
# Providers
#------------------------------------------------------------------------------
provider "aws" {
  region  = "us-east-1"
  version = "1.54"
}

#------------------------------------------------------------------------------
# Modules
#------------------------------------------------------------------------------
module "environment" {
  source = "../environment"

  drone_admin_accounts         = ["mikepham"]
  drone_enabled                = false
  drone_database_instance_type = "t2.micro"
  drone_github_organizations   = ["nativecode-dev"]

  elasticsearch_instance_type = "t2.small.elasticsearch"

  rancher_ami_image          = "ami-0b1db01d775d666c2"
  rancher_availability_zones = ["us-east-1"]
  rancher_certificate_domain = "nativecode.net"
  rancher_environment        = "dev"
  rancher_environment_domain = "nativecode.net"
  rancher_instance_type      = "t2.micro"
  rancher_keypair            = "aws-nativecode-keypair"
  rancher_url                = "https://rancher.nativecode.net"
  rancher_vpc_ids            = ["vpc-ecedad97"]

  rancher_subnets = [[
    "subnet-b27b9f9c",
    "subnet-354be57f",
    "subnet-11e3f94c",
  ]]
}
