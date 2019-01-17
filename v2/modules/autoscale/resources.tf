resource "aws_launch_configuration" "configuration" {
  name = "${var.name}-launch-configuration"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  user_data                   = "${var.user_data}"
}

resource "aws_autoscaling_group" "autoscaling" {
  name = "${var.name}-autoscaling-group"

  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
}
