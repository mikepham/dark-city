resource "vsphere_virtual_machine" "vm" {
  name            = "terraform-test"
  datastore_id    = "${data.vsphere_datastore.datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "other3xLinux64Guest"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    size  = 20
  }
}
