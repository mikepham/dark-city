output "certificate_arn" {
  depends_on  = ["data.aws_acm_certificate.certficate"]
  description = "Certificate ARN"
  value       = "${data.aws_acm_certificate.certficate.arn}"
}
