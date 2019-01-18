provider "aws" {
  region  = "${var.region}"
  version = "1.56.0"
}

module "domain" "dns" {
  source = "../../../modules/vmware/domain"
  domain = "in.nativecode.com"

  domain_controller = "dc01.in.nativecode.com"
  environment       = "prod"
  hostname_alias    = ""
  password          = "${module.secrets.secrets["DOMAIN_NATIVECODE_PASSWORD"]}"
  record_ip         = "192.168.1.40"
  record_name       = "prod"
  record_type       = "A"
  ttl               = "1m0s"
  username          = "${module.secrets.secrets["DOMAIN_NATIVECODE_USERNAME"]}"
}

module "secrets" "secrets" {
  source = "../../../modules/aws/secrets"

  secret_name = "terraform-infrastructure"
}
