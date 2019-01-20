terraform {
  backend "s3" {
    bucket  = "nativecode"
    encrypt = true
    key     = "terraform/rancher-development.tfstate"
    region  = "us-east-1"
  }
}

locals {
  domain      = "nativecode.net"
  environment = "dev"
  subnets     = ["subnet-62d02605"]
  vpc_id      = "vpc-ecedad97"
}

module "env" {
  source = "../../../glue/env-rancher"

  domain      = "${local.domain}"
  environment = "${local.environment}"
  vpc_id      = "${local.vpc_id}"

  autoscale_availability_zone  = "us-east-1"
  autoscale_capacity           = 3
  autoscale_capacity_max       = 5
  autoscale_capacity_min       = 3
  autoscale_cluster_size       = 1
  autoscale_enable_monitoring  = true
  autoscale_iam_profile        = "EC2"
  autoscale_target_health_path = "/health"
  autoscale_target_health_port = 2379
  autoscale_volume_size        = 8

  coreos_cluster_size    = 0
  coreos_reboot_group    = "${local.environment}"
  coreos_reboot_strategy = "off"

  do_backups            = false
  do_count              = 3
  do_image              = "coreos-stable"
  do_ipv6               = false
  do_monitoring         = false
  do_name               = "agent"
  do_private_networking = false
  do_region             = "nyc3"
  do_resize_disk        = true
  do_ssh_keys           = []
  do_size               = "1gb"           # s-2vcpu-2gb
  do_tags               = ["internal"]
  do_volume_ids         = []

  rds_disk_size       = 10
  rds_instance_type   = "t2.micro"
  rds_parameter_group = "default.mysql5.7"
  rds_type            = "mysql"
  rds_type_version    = "5.7"
  rds_username        = "rancher"

  subnets = "${local.subnets}"
}
