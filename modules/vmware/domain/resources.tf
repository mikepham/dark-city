resource "windns" "dns" {
  hostnamealias = "${length(var.record_ip) == 0 ? var.hostname_alias : ""}"
  ipv4address   = "${length(var.hostname_alias) == 0 ? var.record_ip : ""}"
  record_name   = "${var.record_name}"
  record_type   = "${var.record_type}"
  zone_name     = "${var.domain}"
}
