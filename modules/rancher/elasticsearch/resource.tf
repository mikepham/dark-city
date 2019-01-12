resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name           = "${local.domain_slug}"
  elasticsearch_version = "${var.elasticsearch_version}"

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
