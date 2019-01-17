output "zone_id" {
  depends_on = ["aws_route53_zone"]

  description = "AWS Zone ID"
  value       = "${aws_route53_zone.zone.zone_id}"
}
