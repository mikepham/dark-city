output "zone_id" {
  depends_on = ["aws_route53_zone"]

  description = "AWS Zone ID"
  value       = "${aws_route53_zone.zone.zone_id}"
}

output "domain_name" {
  value = "${local.domain_name}"
}

output "domain_slug" {
  value = "${local.domain_slug}"
}

output "env_domain_slug" {
  value = "${local.env_domain_slug}"
}
