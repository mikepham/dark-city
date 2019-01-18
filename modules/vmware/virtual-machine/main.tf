provider "vsphere" {
  version = "1.9.0"

  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  password             = "${var.password}"
  user                 = "${var.username}"
  vsphere_server       = "${var.server}"
}
