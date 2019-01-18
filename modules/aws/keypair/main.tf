provider "external" {
  version = "1.0.0"
}

provider "local" {
  version = "1.1.0"
}

provider "tls" {
  version = "1.2.0"
}

module "env" {
  source = "../../common/env"

  domain      = "${var.domain}"
  environment = "${var.environment}"
}

module "tls" {
  source = "../../common/tls"
}
