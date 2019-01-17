locals {
  domain_slug = "${replace(var.domain, ".", "-")}"
}
