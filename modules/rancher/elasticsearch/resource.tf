resource "aws_cloudwatch_log_group" "cloudwatch" {
  name = "${var.domain}"
}

resource "aws_cloudwatch_log_resource_policy" "cloudwatch" {
  policy_name     = "${local.domain_slug}"
  policy_document = "${data.template_file.cloudwatch.rendered}"
}

resource "aws_elasticsearch_domain" "elasticsearch" {
  access_policies       = "${data.template_file.access_policy.rendered}"
  domain_name           = "${local.domain_slug}"
  elasticsearch_version = "${var.elasticsearch_version}"

  cluster_config {
    dedicated_master_enabled = "${var.dedicated_master_enabled}"
    dedicated_master_type    = "${var.dedicated_master_type}"
    dedicated_master_count   = "${var.dedicated_master_count}"
    instance_count           = "${var.instance_count}"
    instance_type            = "${var.instance_type}"
    zone_awareness_enabled   = "${var.zone_awareness_enabled}"
  }

  encrypt_at_rest {
    enabled = true
  }

  log_publishing_options {
    cloudwatch_log_group_arn = "${aws_cloudwatch_log_group.cloudwatch.arn}"
    log_type                 = "INDEX_SLOW_LOGS"
  }

  node_to_node_encryption {
    enabled = "${var.node2node_encryption}"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.snapshot_start_hour}"
  }

  tags {
    Domain = "${var.domain}"
  }

  vpc_options {
    security_group_ids = "${var.security_groups}"
    subnet_ids         = "${var.subnets}"
  }
}
