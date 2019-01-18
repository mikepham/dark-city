provider "aws" {
  region  = "${var.region}"
  version = "1.56.0"
}

module "autoscale" {
  source = "../../modules/aws/autoscale"
  name   = "${module.domain.env_domain_slug}"

  ami_id                       = "${module.coreos.ami_id}"
  associate_public_ip_address  = "${var.autoscale_associate_public_ip_address}"
  enable_monitoring            = "${var.autoscale_enable_monitoring}"
  instance_type                = "${var.autoscale_instance_type}"
  keypair_name                 = "${module.keypair.keypair_name}"
  max_size                     = "${var.autoscale_max_size}"
  min_size                     = "${var.autoscale_min_size}"
  region                       = "${var.region}"
  release_channel              = "${var.autoscale_release_channel}"
  security_groups              = ["${var.autoscale_security_groups}"]
  user_data                    = "${module.coreos.user_data}"
  volume_delete_on_termination = "${var.autoscale_volume_delete_on_termination}"
  volume_iops                  = "${var.autoscale_volume_iops}"
  volume_size                  = "${var.autoscale_volume_size}"
  volume_type                  = "${var.autoscale_volume_type}"
}

module "coreos" {
  source = "../../modules/common/coreos"

  cluster_size      = "${var.coreos_cluster_size}"
  enable_clustering = "${var.coreos_cluster_size > 0}"
  enable_etcd       = "${var.coreos_cluster_size > 0 && (var.coreos_enable_etcd || var.coreos_enable_ntp)}"
  enable_ntp        = "${var.coreos_enable_etcd || var.coreos_enable_ntp}"
  reboot_group      = "${var.coreos_reboot_group}"
  reboot_strategy   = "${var.coreos_reboot_strategy}"
  region            = "${var.region}"
  swap_size         = "${var.coreos_swap_size}"
}

module "domain" {
  source = "../../modules/aws/domain"

  domain      = "${var.domain}"
  environment = "${var.environment}"
}

module "keypair" {
  source = "../../modules/aws/keypair"

  keypair_name = "${module.domain.env_domain_slug}"
}
