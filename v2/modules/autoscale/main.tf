module "ami" {
  source = "github.com/terraform-community-modules/tf_aws_coreos_ami"

  channel  = "stable"
  region   = "${var.region}"
  virttype = "hvm"
}
