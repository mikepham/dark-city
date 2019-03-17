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

  autoscale_server_availability_zone  = "us-east-1"
  autoscale_server_capacity           = 1
  autoscale_server_capacity_max       = 1
  autoscale_server_capacity_min       = 1
  autoscale_server_cluster_size       = 1
  autoscale_server_enable_monitoring  = true
  autoscale_server_iam_profile        = "EC2"
  autoscale_server_target_health_path = "/health"
  autoscale_server_target_health_port = 2379
  autoscale_server_volume_size        = 8

  autoscale_agent_availability_zone  = "us-east-1"
  autoscale_agent_capacity           = 3
  autoscale_agent_capacity_max       = 5
  autoscale_agent_capacity_min       = 3
  autoscale_agent_cluster_size       = 1
  autoscale_agent_enable_monitoring  = true
  autoscale_agent_iam_profile        = "EC2"
  autoscale_agent_target_health_path = "/health"
  autoscale_agent_target_health_port = 2379
  autoscale_agent_volume_size        = 8

  coreos_agent_cluster_size    = 0
  coreos_agent_reboot_group    = "${local.environment}"
  coreos_agent_reboot_strategy = "off"

  coreos_server_cluster_size    = 0
  coreos_server_reboot_group    = "${local.environment}"
  coreos_server_reboot_strategy = "off"

  rds_disk_size       = 10
  rds_instance_type   = "t2.micro"
  rds_parameter_group = "default.mysql5.7"
  rds_type            = "mysql"
  rds_type_version    = "5.7"
  rds_username        = "rancher"

  subnets = "${local.subnets}"
}
