module "env" {
  source = "../../common/env"

  domain      = "${var.domain}"
  environment = "${var.environment}"
}
