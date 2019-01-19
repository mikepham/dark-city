output "certificate_arn" {
  depends_on = ["data.aws_acm_certificate.certificate"]

  description = "Certificate ARN"
  value       = "${data.aws_acm_certificate.certificate.arn}"
}

output "created_certificate_arn" {
  depends_on = ["aws_acm_certificate.certificate"]

  description = "Certificate ARNs"
  value       = ["${aws_acm_certificate.certificate.*.arn}"]
}
