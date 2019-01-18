module "env" {
  source = "../../modules/common/env"

  domain      = "${var.domain}"
  environment = "${var.environment}"
}
