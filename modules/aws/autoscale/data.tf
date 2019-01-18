data "aws_iam_instance_profile" "iam_ec2" {
  name = "${var.iam_profile}"
}

data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}
