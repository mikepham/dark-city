resource "aws_cloudwatch_log_resource_policy" "cloudwatch" {
  policy_name     = "${local.domain_slug}"
  policy_document = "${data.template_file.cloudwatch.rendered}"
}

resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name           = "${local.domain_slug}"
  elasticsearch_version = "${var.elasticsearch_version}"

  access_policies = "${data.template_file.access_policy.rendered}"

  cluster_config {
    instance_type = "${var.instance_type}"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.snapshot_start_hour}"
  }

  tags {
    Domain = "${var.domain}"
  }
}
