locals {
  domain_name     = "${length(var.environment) == 0 ? var.domain : "${var.environment}.${var.domain}"}"
  domain_root     = "${var.domain}"
  domain_slug     = "${replace(local.domain_root, ".", "-")}"
  env_domain_slug = "${replace("${local.domain_name}", ".", "-")}"
}
