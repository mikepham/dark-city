module "rancher_agent" {
  source = "../../modules/rancher/agents"
}

module "rancher_agent_autoscale" {
  source = "../../modules/aws/autoscale"
  name   = "${module.domain.env_domain_slug}"

  ami_id                       = "${module.rancher_agent_coreos.ami_id}"
  associate_public_ip_address  = "${var.autoscale_associate_public_ip_address}"
  availability_zone            = "${var.autoscale_availability_zone}"
  capacity                     = "${var.autoscale_capacity}"
  capacity_max                 = "${var.autoscale_capacity_max}"
  capacity_min                 = "${var.autoscale_capacity_min}"
  cluster_size                 = "${var.autoscale_cluster_size}"
  enable_monitoring            = "${var.autoscale_enable_monitoring}"
  health_check_type            = "${var.autoscale_health_check_type}"
  iam_profile                  = "${var.autoscale_iam_profile}"
  instance_type                = "${var.autoscale_instance_type}"
  keypair_name                 = "${module.keypair.keypair_name}"
  region                       = "${var.region}"
  release_channel              = "${var.autoscale_release_channel}"
  subnets                      = ["${var.subnets}"]
  target_health_path           = "${var.autoscale_target_health_path}"
  target_health_port           = "${var.autoscale_target_health_port}"
  target_protocol              = "${var.autoscale_target_protocol}"
  target_port                  = "${var.autoscale_target_port}"
  termination_policies         = "${var.autoscale_termination_policies}"
  user_data                    = "${module.rancher_agent_coreos.user_data}"
  vpc_id                       = "${var.vpc_id}"
  volume_delete_on_termination = "${var.autoscale_volume_delete_on_termination}"
  volume_iops                  = "${var.autoscale_volume_iops}"
  volume_size                  = "${var.autoscale_volume_size}"
  volume_type                  = "${var.autoscale_volume_type}"
  wait_for_elb_capacity        = "${var.autoscale_wait_for_elb_capacity}"

  security_groups = [
    "${module.rancher_agent_autoscale.autoscaling_security_groups}",
    "${module.efs.efs_security_group}",
  ]
}

module "rancher_agent_coreos" {
  source = "../../modules/common/coreos"

  additional_configurations = [
    "${module.rancher_agent.ignition}",
  ]

  cluster_size      = "${var.coreos_cluster_size}"
  enable_clustering = "${var.coreos_cluster_size > 0}"
  enable_etcd       = "${var.coreos_cluster_size > 0 && (var.coreos_enable_etcd || var.coreos_enable_ntp)}"
  enable_ntp        = "${var.coreos_enable_etcd || var.coreos_enable_ntp}"
  reboot_group      = "${var.coreos_reboot_group}"
  reboot_strategy   = "${var.coreos_reboot_strategy}"
  region            = "${var.region}"
  swap_size         = "${var.coreos_swap_size}"
}
