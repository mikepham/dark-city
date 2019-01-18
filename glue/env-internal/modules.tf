provider "aws" {
  region  = "${var.region}"
  version = "1.56.0"
}

module "domain" "dns" {
  source = "../../modules/vmware/domain"
  domain = "${var.domain}"

  domain_controller = "${var.dns_domain_controller}"
  environment       = "${var.environment}"
  hostname_alias    = "${var.dns_hostname_alias}"
  password          = "${module.secrets.secrets["DOMAIN_NATIVECODE_PASSWORD"]}"
  record_ip         = "${var.dns_record_ip}"
  record_name       = "${var.dns_record_name}"
  record_type       = "${var.dns_record_type}"
  username          = "${module.secrets.secrets["DOMAIN_NATIVECODE_USERNAME"]}"
}

module "secrets" "secrets" {
  source = "../../modules/aws/secrets"

  secret_name = "${var.secret_name}"
}

module "virtual_machine" {
  source = "../../modules/vmware/virtual-machine"

  allow_unverified_ssl = "${var.vmware_allow_unverified_ssl}"
  host                 = "vm01"
  password             = "${module.secrets.secrets["VMWARE_PASSWORD"]}"
  server               = "vm01.in.nativecode.com"
  username             = "${module.secrets.secrets["VMWARE_USERNAME"]}"
}
