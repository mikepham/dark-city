resource "aws_launch_configuration" "configuration" {
  name = "${var.name}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  enable_monitoring           = "${var.enable_monitoring}"
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.keypair_name}"
  user_data                   = "${var.user_data}"

  security_groups = ["${var.security_groups}"]

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    delete_on_termination = "${var.volume_delete_on_termination}"
    iops                  = "${var.volume_iops}"
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
  }
}

resource "aws_autoscaling_group" "autoscaling" {
  name = "${var.name}"

  depends_on = [
    "aws_launch_configuration.configuration",
  ]

  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
}
