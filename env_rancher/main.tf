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

  ami_image              = "ami-0b1db01d775d666c2"
  availability_zone      = "us-east-1"
  database_instance_type = "db.t2.micro"
  domain                 = "nativecode.net"
  keypair                = "aws-nativecode-keypair"
  instance_type          = "t2.micro"
  volume_size            = 16
  vpc_id                 = "vpc-ecedad97"

  subnets = [
    "subnet-b27b9f9c",
    "subnet-354be57f",
  ]
}