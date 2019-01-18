terraform {
  backend "etcdv3" {
    endpoints = ["etcd:2379"]
    lock      = true
    prefix    = "/terraform/state/"
  }
}

module "env" {
  source = "../../../glue/env-internal"

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
