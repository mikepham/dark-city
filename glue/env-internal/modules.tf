module "secrets" {
  source = "../../modules/aws/secrets"

  secret_name = "${var.secret_name}"
}

module "virtual_machine" {
  source = "../../modules/vmware/virtual-machine"

  allow_unverified_ssl = "${var.vmware_allow_unverified_ssl}"
  disk_label           = "${var.disk_label}"
  disk_size            = "${var.disk_size}"
  host                 = "vm01"
  password             = "${module.secrets.secrets["VMWARE_PASSWORD"]}"
  server               = "vm01.in.nativecode.com"
  username             = "${module.secrets.secrets["VMWARE_USERNAME"]}"
}
