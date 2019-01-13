data "aws_caller_identity" "account" {}

data "aws_route53_zone" "zone" {
  name = "${var.environment_domain_tld}."
}
