locals {
  reboot_strategy = "${var.enable_etcd ? "etcd-lock" : var.reboot_strategy}"
}
