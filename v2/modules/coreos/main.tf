provider "http" {
  version = "1.0.1"
}

provider "null" {
  version = "1.0.0"
}

provider "template" {
  version = "2.0.0"
}

module "ami" {
  source = "github.com/terraform-community-modules/tf_aws_coreos_ami"

  channel  = "${var.release_channel}"
  region   = "${var.region}"
  virttype = "hvm"
}
