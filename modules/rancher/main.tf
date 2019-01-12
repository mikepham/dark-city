#------------------------------------------------------------------------------
# Providers
#------------------------------------------------------------------------------
provider "rancher" {
  api_url    = "${var.environment_rancher_url}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  version    = "1.2.1"
}

provider "template" {
  version = "1.0.0"
}

module "security" {
  source = "security"

  environment_name = "${var.environment_name}"
  vpc_ids          = "${var.vpc_ids}"
}

module "cluster" {
  source = "cluster"

  agent_startup           = "${rancher_registration_token.member.command}"
  agent_token             = "${rancher_registration_token.member.token}"
  ami_image               = "${var.ami_image}"
  availability_zones      = "${var.availability_zones}"
  capacity                = "${var.capacity}"
  capacity_max            = "${var.capacity_max}"
  capacity_min            = "${var.capacity_min}"
  certificate_arn         = "${var.certificate_arn}"
  cluster_name            = "${var.environment_name}"
  cluster_size            = "${var.cluster_size}"
  cluster_member_size     = "${var.cluster_member_size}"
  environment_name        = "${var.environment_name}"
  etcd_token              = "${var.etcd_token}"
  environment_domain      = "${var.environment_domain}"
  environment_domain_tld  = "${var.environment_domain_tld}"
  environment_name        = "${var.environment_name}"
  environment_rancher_url = "${var.environment_rancher_url}"
  iam_profile             = "${var.iam_profile}"
  instance_type           = "${var.instance_type}"
  keypair                 = "${var.keypair}"
  monitoring              = "${var.monitoring}"
  ntp_hosts               = "${var.ntp_hosts}"
  security_groups         = ["${module.security.security_groups}"]
  subnets                 = "${var.subnets}"
  use_public_ip           = "${var.use_public_ip}"
  volume_size             = "${var.volume_size}"
  vpc_ids                 = "${var.vpc_ids}"
}

module "storage" {
  source = "storage"

  environment     = "${var.environment_name}"
  security_groups = ["${module.security.security_group_storage}"]
  subnets         = "${var.subnets}"
}
