provider "aws" {
  region  = "${var.region}"
  version = ">=1.56"
}

provider "external" {
  version = ">=1.0"
}

provider "http" {
  version = ">=1.0"
}

provider "local" {
  version = ">=1.1"
}

provider "template" {
  version = ">=2.0"
}

provider "tls" {
  version = ">=1.2"
}

module "alb" {
  source = "../../modules/aws/alb"

  certificate_arn = "${module.certificates.created_certificate_arn}"
  domain_slug     = "${module.domain.env_domain_slug}"
  name            = "${var.environment}"

  security_groups = [
    "${module.rancher_server_autoscale.autoscaling_security_groups}",
  ]

  subnets = [
    "${var.subnets}",
  ]

  target_group_arns = [
    "${module.rancher_server_autoscale.autoscaling_group_targets["arns"]}",
  ]
}

module "certificates" {
  source = "../../modules/aws/certificates"

  domain = "${var.domain}"

  certificates = [
    "${var.domain}",
    "*.${var.domain}",
  ]
}

module "domain" {
  source = "../../modules/aws/domain"

  domain      = "${var.domain}"
  environment = "${var.environment}"
}

module "keypair" {
  source = "../../modules/aws/keypair"
  domain = "${var.domain}"

  environment  = "${var.environment}"
  keypair_name = "${module.domain.env_domain_slug}"
}

module "secrets" {
  source = "../../modules/aws/secrets"

  secret_name = "terraform-infrastructure"
}

module "efs" {
  source = "../../modules/aws/efs"
  domain = "${var.domain}"

  enabled     = "${var.efs_enabled}"
  environment = "${var.environment}"
  name        = "${module.domain.env_domain_slug}"
  subnets     = ["${var.subnets}"]
  vpc_ids     = ["${var.vpc_id}"]
}
