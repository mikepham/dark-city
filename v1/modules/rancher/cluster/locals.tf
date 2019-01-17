locals {
  domain_slug = "${replace(var.environment_domain, ".", "-")}"

  target_group = "${local.domain_slug}"
}
