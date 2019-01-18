terraform {
  backend "s3" {
    bucket  = "nativecode"
    encrypt = true
    key     = "terraform/rancher-development.tfstate"
    region  = "us-east-1"
  }
}

module "env" {
  source = "../../../glue/env-rancher"

  autoscale_availability_zone    = "us-east-1"
  autoscale_capacity             = 1
  autoscale_capacity_max         = 1
  autoscale_capacity_min         = 1
  autoscale_enable_monitoring    = true
  autoscale_iam_profile          = "EC2"
  autoscale_target_port          = 80
  autoscale_target_protocol      = "HTTP"
  autoscale_target_health_path   = "/health"
  autoscale_target_health_port   = 2379
  autoscale_termination_policies = ["OldestInstance"]
  autoscale_volume_size          = 8
  vpc_id                         = "vpc-ecedad97"

  autoscale_subnets = [
    "subnet-62d02605",
  ]

  domain                 = "nativecode.net"
  coreos_cluster_size    = 0
  coreos_reboot_group    = "dev"
  coreos_reboot_strategy = "off"
  environment            = "dev"
}
