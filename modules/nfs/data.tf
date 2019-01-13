data "aws_vpc" "vpc" {
  count = "${length(var.vpc_ids)}"
  id    = "${element(var.vpc_ids, count.index)}"
}
