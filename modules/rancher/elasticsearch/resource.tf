resource "aws_security_group" "elasticsearch" {
  count       = "${var.enabled * length(var.vpc_ids)}"
  name_prefix = "${var.environment}-elasticsearch-"
  description = "Allows ElasticSearch traffic from instances within the VPC."
  vpc_id      = "${element(var.vpc_ids, count.index)}"

  egress {
    from_port = 9200
    to_port   = 9200
    protocol  = "tcp"

    cidr_blocks = ["${element(data.aws_vpc.vpc.*.cidr_block, count.index)}"]
  }

  ingress {
    from_port = 9200
    to_port   = 9200
    protocol  = "tcp"

    cidr_blocks = ["${element(data.aws_vpc.vpc.*.cidr_block, count.index)}"]
  }

  tags {
    Name = "elasticsearch-${var.environment}"
  }
}

resource "aws_cloudwatch_log_group" "cloudwatch" {
  count = "${var.enabled}"
  name  = "${var.domain}"
}

resource "aws_cloudwatch_log_resource_policy" "cloudwatch" {
  count           = "${var.enabled}"
  policy_name     = "${local.domain_slug}"
  policy_document = "${data.template_file.cloudwatch.rendered}"
}

resource "aws_elasticsearch_domain" "elasticsearch" {
  count = "${var.enabled}"

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

  ebs_options {
    ebs_enabled = true
    volume_size = "${var.volume_size}"
    volume_type = "${var.volume_type}"
  }

  encrypt_at_rest {
    enabled = "${var.encrypt_at_rest}"
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
    security_group_ids = ["${aws_security_group.elasticsearch.id}"]
    subnet_ids         = ["${element(var.subnets, 1)}"]
  }
}
