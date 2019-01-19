data "aws_acm_certificate" "certificate" {
  domain      = "${var.domain}"
  most_recent = true
}

data "aws_route53_zone" "zone" {
  name         = "${var.domain}."
  private_zone = false
}
