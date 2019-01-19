data "ct_config" "config" {
  content  = "${file("${path.module}/.files/default.yaml")}"
  platform = "ec2"

  snippets = [
    "${data.template_file.common.rendered}",
    "${var.enable_clustering ? data.template_file.etcd_cluster.rendered : data.template_file.etcd.rendered}",
    "${var.enable_ntp ? data.template_file.ntp.rendered : data.template_file.common.rendered}",
  ]
}

data "http" "discovery_url" {
  count = "${var.enable_clustering ? 1 : 0}"

  url = "https://discovery.etcd.io/new${var.cluster_size == 0 ? "" : "?new=${var.cluster_size}"}"
}

data "template_file" "common" {
  template = "${file("${path.module}/.files/common.yaml")}"

  vars {
    reboot_group    = "${var.reboot_group}"
    reboot_strategy = "${var.reboot_strategy}"
    swap_size       = "${var.swap_size}"
  }
}

data "template_file" "etcd" {
  template = "${file("${path.module}/.files/etcd.yaml")}"
}

data "template_file" "etcd_cluster" {
  template = "${file("${path.module}/.files/etcd-cluster.yaml")}"

  vars {
    discovery_url = "${join("", data.http.discovery_url.*.body)}"
  }
}

data "template_file" "ntp" {
  template = "${file("${path.module}/.files/ntp.yaml")}"

  vars {
    ntp_host = "${var.ntp_host}"
  }
}

data "http" "coreos_manifest" {
  url = "https://${var.release_channel}.release.core-os.net/amd64-usr/current/coreos_production_ami_hvm_us-east-1.txt"
}
