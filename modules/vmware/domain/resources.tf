resource "windows-dns_recprd" "dns" {
  name = "${local.domain_name}"

  domain = "${var.domain}"
  ttl    = "${var.ttl}"
  type   = "${var.dns_record_type}"
  value  = "${var.dns_record_value}"
}
