resource "aws_launch_configuration" "configuration" {
  name = "${var.name}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  enable_monitoring           = "${var.enable_monitoring}"
  iam_instance_profile        = "${data.aws_iam_instance_profile.iam_ec2.arn}"
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

  availability_zones        = ["${var.availability_zone}"]
  desired_capacity          = "${var.capacity}"
  force_delete              = false
  health_check_grace_period = 180
  health_check_type         = "${var.health_check_type}"
  launch_configuration      = "${aws_launch_configuration.configuration.name}"
  max_size                  = "${var.capacity_max}"
  min_size                  = "${var.capacity_min}"
  target_group_arns         = ["${aws_alb_target_group.target_group.arn}"]
  termination_policies      = "${var.termination_policies}"
  vpc_zone_identifier       = "${var.subnets}"
}

resource "aws_alb_target_group" "target_group" {
  name = "${var.name}"

  port     = "${var.target_port}"
  protocol = "${var.target_protocol}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "${var.target_health_path}"
    port                = "${var.target_health_port}"
  }

  tags {
    Name = "${var.name}-alb-target"
  }
}
