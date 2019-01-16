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

  ami_image                = "ami-0547d9705af5e8fb2"
  availability_zone        = "us-east-1"
  capacity                 = 1
  capacity_max             = 1
  capacity_min             = 1
  cluster_size             = 1
  database_instance_type   = "db.t2.micro"
  domain                   = "nativecode.net"
  enable_delete_protection = false
  instance_type            = "t2.micro"
  swap_size                = 2048
  volume_size              = 8
  vpc_id                   = "vpc-ecedad97"

  subnets = [
    "subnet-b27b9f9c",
    "subnet-354be57f",
  ]
}
