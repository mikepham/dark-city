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

  autoscale_enable_monitoring = true
  autoscale_volume_size       = 8
  domain                      = "nativecode.net"
  coreos_cluster_size         = 0
  coreos_reboot_group         = "dev"
  coreos_reboot_strategy      = "off"
  environment                 = "dev"
}
