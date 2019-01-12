data "aws_acm_certificate" "certficate" {
  domain      = "${var.domain}"
  most_recent = true
}
