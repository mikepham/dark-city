locals {
  domain = "${var.rancher_environment}.${var.rancher_environment_domain}"
}

#------------------------------------------------------------------------------
# Modules
#------------------------------------------------------------------------------
module "certificates" {
  source = "../modules/certificates"

  domain = "${var.rancher_certificate_domain}"
}

module "secrets" {
  source = "../modules/secrets"

  secret_name = "terraform-infrastructure"
}

module "rancher" {
  source = "../modules/rancher"

  access_key              = "${module.secrets.secrets["RANCHER_ACCESS_KEY"]}"
  ami_image               = "${var.rancher_ami_image}"
  availability_zones      = "${var.rancher_availability_zones}"
  aws_subnets             = "${var.rancher_subnets}"
  capacity                = "${var.rancher_capacity}"
  capacity_max            = "${var.rancher_capacity_max}"
  capacity_min            = "${var.rancher_capacity_min}"
  certificate_arn         = "${module.certificates.aws_certificate_arn}"
  cluster_name            = "${var.rancher_environment}"
  cluster_size            = "${var.rancher_cluster_size}"
  cluster_member_size     = "${var.rancher_cluster_member_size}"
  etcd_token              = "${var.rancher_etcd_token}"
  environment_domain      = "${local.domain}"
  environment_domain_tld  = "${var.rancher_environment_domain}"
  environment_name        = "${var.rancher_environment}"
  environment_rancher_url = "${var.rancher_url}"
  iam_profile             = "${var.rancher_iam_profile}"
  instance_type           = "${var.rancher_instance_type}"
  keypair                 = "${var.rancher_keypair}"
  monitoring              = "${var.rancher_monitoring}"
  ntp_hosts               = "${var.rancher_ntp_hosts}"
  secret_key              = "${module.secrets.secrets["RANCHER_SECRET_KEY"]}"
  subnets                 = "${var.rancher_subnets}"
  use_public_ip           = "${var.rancher_use_public_ip}"
  volume_size             = "${var.rancher_volume_size}"
  vpc_ids                 = "${var.rancher_vpc_ids}"
}
