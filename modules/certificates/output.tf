output "aws_certificate_arn" {
  value = "${data.aws_acm_certificate.certficate.arn}"
}
