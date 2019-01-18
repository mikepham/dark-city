data "vsphere_datacenter" "datacenter" {}

data "vsphere_datastore" "datastore" {
  name          = "STORAGE"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_host" "host" {
  name          = "${var.host}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "network" {
  name          = "SAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.host}/Resources"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
