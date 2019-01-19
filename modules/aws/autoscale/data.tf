data "aws_iam_instance_profile" "profile" {
  name = "${var.iam_profile}"
}

data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}
