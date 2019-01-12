data "aws_vpc" "vpc" {
  count = "${length(var.vpc_ids)}"
  id    = "${element(var.vpc_ids, count.index)}"
}

data "template_file" "access_policy" {
  template = "${file("${path.module}/.files/access-policy.json")}"

  vars {
    account_id        = "${var.account_id}"
    availability_zone = "${element(var.availability_zones, 1)}"
    domain            = "${local.domain_slug}"
  }
}

data "template_file" "cloudwatch" {
  template = "${file("${path.module}/.files/cloudwatch.json")}"
}
