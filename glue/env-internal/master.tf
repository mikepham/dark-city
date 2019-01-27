module "droplet_coreos" {
  source = "../../modules/common/coreos"

  additional_configurations = []

  cluster_size      = "${var.do_count}"
  enable_clustering = "${var.do_count > 0}"
  enable_etcd       = "${var.do_count > 0 && (var.coreos_enable_etcd || var.coreos_enable_ntp)}"
  enable_ntp        = "${var.coreos_enable_etcd || var.coreos_enable_ntp}"
  reboot_group      = "${var.coreos_reboot_group}"
  reboot_strategy   = "${var.coreos_reboot_strategy}"
  region            = "${var.region}"
  swap_size         = "${var.coreos_swap_size}"
}

module "droplet" {
  source = "../../modules/digitalocean/droplet"

  backups            = "${var.do_backups}"
  count              = "${var.do_count}"
  image              = "${var.do_image}"
  ipv6               = "${var.do_ipv6}"
  monitoring         = "${var.do_monitoring}"
  name               = "${var.do_name}"
  private_networking = "${var.do_private_networking}"
  region             = "${var.do_region}"
  resize_disk        = "${var.do_resize_disk}"
  ssh_keys           = "${var.do_ssh_keys}"
  size               = "${var.do_size}"
  tags               = "${var.do_tags}"
  user_data          = "${module.droplet_coreos.user_data}"
  volume_ids         = "${var.do_volume_ids}"
}
