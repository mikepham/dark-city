module "environment" {
  source = "../../../glue"

  autoscale_enable_monitoring = true
  autoscale_volume_size       = 8
  domain                      = "nativecode.net"
  coreos_cluster_size         = 0
  coreos_reboot_group         = "dev"
  coreos_reboot_strategy      = "off"
  environment                 = "dev"
}
