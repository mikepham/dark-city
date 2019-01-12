data "template_file" "access_policy" {
  template = "${file("${path.module}/.files/access_policy.json")}"

  vars {
    account_id        = "${var.account_id}"
    availability_zone = "${element(var.availability_zones, 1)}"
    domain            = "${local.domain_slug}"
  }
}

data "template_file" "cloudwatch" {
  template = "${file("${path.module}/.files/cloudwatch.json")}"
}
