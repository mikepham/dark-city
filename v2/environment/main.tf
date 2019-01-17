provider "aws" {
  region  = "${var.region}"
  version = "1.56"
}

module "autoscale" {
  source = "../modules/autoscale"

  associate_public_ip_address = "${var.autoscale_associate_public_ip_address}"
  instance_type               = "${var.autoscale_instance_type}"
  max_size                    = "${var.autoscale_max_size}"
  min_size                    = "${var.autoscale_min_size}"
  name                        = "${var.environment}"
  region                      = "${var.region}"
}

module "coreos" {
  source = "../modules/coreos"

  cluster_size      = "${var.coreos_cluster_size}"
  enable_clustering = "${var.coreos_cluster_size > 0}"
  enable_etcd       = "${var.coreos_cluster_size > 0 && (var.coreos_enable_etcd || var.coreos_enable_ntp)}"
  enable_ntp        = "${var.coreos_enable_etcd || var.coreos_enable_ntp}"
  reboot_group      = "${var.coreos_reboot_group}"
  reboot_strategy   = "${var.coreos_reboot_strategy}"
  swap_size         = "${var.coreos_swap_size}"
}

module "domain" {
  source = "../modules/domain"

  domain = "${var.domain}"
}
