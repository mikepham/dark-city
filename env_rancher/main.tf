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
# Modules
#------------------------------------------------------------------------------
module "rancher_server" {
  source = "rancher-server"

  ami_image          = "ami-0b1db01d775d666c2"
  availability_zones = ["us-east-1"]
  domain             = "nativecode.net"
  filesystem_id      = "fs-a605a047"
  instance_type      = "t2.micro"
  keypair            = "aws-nativecode-keypair"
  volume_size        = 16
  volume_type        = "gp2"
  vpc_id             = "vpc-ecedad97"

  subnets = [
    "subnet-b27b9f9c",
    "subnet-354be57f",
    "subnet-11e3f94c",
  ]
}
