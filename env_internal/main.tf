#------------------------------------------------------------------------------
# Terraform
#------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.11.11"

  backend "etcdv3" {
    endpoints = ["etcd:2379"]
    lock      = true
    prefix    = "terraform/internal.tfstate"
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

  # Overrides
  drone_database_instance_type        = "t2.micro"
  elasticsearch_dedicated_master_type = "t2.small.elasticsearch"
  elasticsearch_instance_type         = "t2.small.elasticsearch"
  elasticsearch_volume_size           = 10
  rancher_certificate_domain          = "int.nativecode.net"
  rancher_environment                 = "int"
  rancher_instance_type               = "t2.micro"
  rancher_volume_size                 = 10

  # Drone
  drone_admin_accounts       = ["mikepham"]
  drone_enabled              = false
  drone_github_organizations = ["nativecode-dev"]

  # ElasticSearch
  elasticsearch_dedicated_master_count   = 1
  elasticsearch_dedicated_master_enabled = false
  elasticsearch_encrypt_at_rest          = false
  elasticsearch_instance_count           = 1
  elasticsearch_node2node_encryption     = false
  elasticsearch_version                  = 6.3
  elasticsearch_volume_type              = "gp2"
  elasticsearch_zone_awareness_enabled   = false

  # Rancher
  rancher_ami_image          = "ami-0b1db01d775d666c2"
  rancher_availability_zones = ["us-east-1"]
  rancher_environment_domain = "nativecode.net"
  rancher_keypair            = "aws-nativecode-keypair"
  rancher_url                = "https://rancher.nativecode.net"
  rancher_vpc_ids            = ["vpc-ecedad97"]

  rancher_subnets = [[
    "subnet-b27b9f9c",
    "subnet-354be57f",
    "subnet-11e3f94c",
  ]]
}
