locals {
  create_key_pair    = "${var.keypair != "" ? 0 : 1}"
  domain_slug        = "${replace(var.domain, ".", "-")}"
  loadbalancer_count = 1
}
