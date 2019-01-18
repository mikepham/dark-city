provider "aws" {
  region  = "${var.region}"
  version = "1.56.0"
}

module "domain" "dns" {
  source = "../../../modules/vmware/domain"
  domain = "in.nativecode.com"

  dns_record_type   = "A"
  dns_record_value  = "192.168.1.40"
  domain_controller = "dc01.in.nativecode.com"
  environment       = "prod"
  ttl               = "1m0s"
  password          = "${module.secrets.secrets["DOMAIN_NATIVECODE_PASSWORD"]}"
  username          = "${module.secrets.secrets["DOMAIN_NATIVECODE_USERNAME"]}"
}

module "secrets" "" {
  source = "../../../modules/aws/secrets"

  secret_name = "terraform-infrastructure"
}
