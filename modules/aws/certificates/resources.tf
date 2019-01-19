resource "aws_acm_certificate" "certificate" {
  domain_name               = "${var.domain}"
  subject_alternative_names = ["${var.certificates}"]
  validation_method         = "${var.validation_method}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "dns" {
  name    = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name}"
  records = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  type    = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type}"

  ttl     = 60
  zone_id = "${data.aws_route53_zone.zone.id}"
}

resource "aws_acm_certificate_validation" "validaton" {
  certificate_arn         = "${aws_acm_certificate.certificate.arn}"
  validation_record_fqdns = ["${aws_route53_record.dns.fqdn}"]
}
