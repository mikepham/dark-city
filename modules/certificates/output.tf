output "aws_certificate_arn" {
  description = "Certificate ARN"
  value = "${data.aws_acm_certificate.certficate.arn}"
}
