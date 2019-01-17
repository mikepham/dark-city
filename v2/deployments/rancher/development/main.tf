module "environment" {
  source = "../../../environment"

  domain                 = "nativecode.net"
  coreos_cluster_size    = 0
  coreos_enable_etcd     = false
  coreos_enable_ntp      = false
  coreos_reboot_group    = "dev"
  coreos_reboot_strategy = "off"
  environment            = "dev"
}
