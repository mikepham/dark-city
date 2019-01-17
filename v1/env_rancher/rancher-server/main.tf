#------------------------------------------------------------------------------
# Terraform
#------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.11.11"

  backend "s3" {
    bucket  = "nativecode"
    encrypt = true
    key     = "terraform/rancher-server.tfstate"
    region  = "us-east-1"
  }
}

#------------------------------------------------------------------------------
# Providers
#------------------------------------------------------------------------------
provider "aws" {
  region  = "us-east-1"
  version = "1.54"
}

provider "external" {
  version = "1.0"
}

provider "http" {
  version = "1.0.0"
}

provider "local" {
  version = "1.1.0"
}

provider "random" {
  version = "2.0.0"
}

provider "template" {
  version = "1.0.0"
}

provider "tls" {
  version = "1.0.0"
}

#------------------------------------------------------------------------------
# Modules
#------------------------------------------------------------------------------
module "certificates" {
  source = "../../modules/certificates"

  domain = "${var.domain}"
}

module "secrets" {
  source = "../../modules/secrets"

  secret_name = "terraform-infrastructure"
}
