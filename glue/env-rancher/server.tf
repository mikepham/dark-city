module "rancher_server_autoscale" {
  source = "../../modules/aws/autoscale"
  name   = "${module.domain.env_domain_slug}"

  ami_id                       = "${module.rancher_server_coreos.ami_id}"
  associate_public_ip_address  = "${var.autoscale_server_associate_public_ip_address}"
  availability_zone            = "${var.autoscale_server_availability_zone}"
  capacity                     = "${var.autoscale_server_capacity}"
  capacity_max                 = "${var.autoscale_server_capacity_max}"
  capacity_min                 = "${var.autoscale_server_capacity_min}"
  cluster_size                 = "${var.autoscale_server_cluster_size}"
  enable_monitoring            = "${var.autoscale_server_enable_monitoring}"
  health_check_type            = "${var.autoscale_server_health_check_type}"
  iam_profile                  = "${var.autoscale_server_iam_profile}"
  instance_type                = "${var.autoscale_server_instance_type}"
  keypair_name                 = "${module.keypair.keypair_name}"
  region                       = "${var.region}"
  release_channel              = "${var.autoscale_server_release_channel}"
  subnets                      = ["${var.subnets}"]
  target_health_path           = "${var.autoscale_server_target_health_path}"
  target_health_port           = "${var.autoscale_server_target_health_port}"
  target_protocol              = "${var.autoscale_server_target_protocol}"
  target_port                  = "${var.autoscale_server_target_port}"
  termination_policies         = "${var.autoscale_server_termination_policies}"
  user_data                    = "${module.rancher_server_coreos.user_data}"
  vpc_id                       = "${var.vpc_id}"
  volume_delete_on_termination = "${var.autoscale_server_volume_delete_on_termination}"
  volume_iops                  = "${var.autoscale_server_volume_iops}"
  volume_size                  = "${var.autoscale_server_volume_size}"
  volume_type                  = "${var.autoscale_server_volume_type}"
  wait_for_elb_capacity        = "${var.autoscale_server_wait_for_elb_capacity}"

  security_groups = [
    "${module.rancher_server_autoscale.autoscaling_security_groups}",
    "${module.efs.efs_security_group}",
  ]
}

module "rancher_server_coreos" {
  source = "../../modules/common/coreos"

  additional_configurations = [
    "${module.rancher_server.ignition}",
  ]

  cluster_size      = "${var.coreos_server_cluster_size}"
  enable_clustering = "${var.coreos_server_cluster_size > 0}"
  enable_etcd       = "${var.coreos_server_cluster_size > 0 && (var.coreos_server_enable_etcd || var.coreos_server_enable_ntp)}"
  enable_ntp        = "${var.coreos_server_enable_etcd || var.coreos_server_enable_ntp}"
  reboot_group      = "${var.coreos_server_reboot_group}"
  reboot_strategy   = "${var.coreos_server_reboot_strategy}"
  region            = "${var.region}"
  swap_size         = "${var.coreos_server_swap_size}"
}

module "rancher_server" {
  source = "../../modules/rancher/server"

  disk_size       = "${var.rds_disk_size}"
  instance_type   = "${var.rds_instance_type}"
  name            = "${module.domain.domain_slug}"
  password        = "${length(var.rds_password) == 0 ? module.secrets.secrets["RANCHER_DATABASE_PASSWORD"] : var.rds_password}"
  parameter_group = "${var.rds_parameter_group}"
  type            = "${var.rds_type}"
  type_version    = "${var.rds_type_version}"
  username        = "${var.rds_username}"
}
