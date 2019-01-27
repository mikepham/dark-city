terraform {
  backend "etcdv3" {
    endpoints = ["etcd:2379"]
    lock      = true
    prefix    = "/terraform/state/"
  }
}

module "env" {
  source = "../../../glue/env-internal"

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

  domain                      = "in.nativecode.com"
  environment                 = "int"
  dns_domain_controller       = "dc01.in.nativecode.com"
  dns_record_ip               = "192.168.1.40"
  dns_record_name             = "int"
  dns_record_type             = "A"
  region                      = "${var.region}"
  secret_name                 = "terraform-infrastructure"
  vmware_allow_unverified_ssl = true
}
