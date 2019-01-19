module "ami" {
  source = "github.com/terraform-community-modules/tf_aws_coreos_ami"

  channel  = "${var.release_channel}"
  region   = "${var.region}"
  virttype = "hvm"
}
