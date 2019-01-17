locals {
  ami_latest      = "${lookup(local.ami_list, "name")}"
  ami_list        = ["${data.jsondecode_decode.coreos_manifest.object["amis"]}"]
  reboot_strategy = "${var.enable_etcd ? "etcd-lock" : var.reboot_strategy}"
}

data "jsondecode_decode" "test" {
  depends_on = ["data.jsondecode_decode.coreos_manifest"]
  input      = "${jsonencode(local.ami_list)}"
}
