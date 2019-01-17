resource "aws_launch_configuration" "cluster" {
  count       = "${var.cluster_size}"
  name_prefix = "${var.environment_name}-rancher-"

  associate_public_ip_address = "${var.use_public_ip}"
  enable_monitoring           = "${var.monitoring}"
  iam_instance_profile        = "${data.aws_iam_instance_profile.iam_ec2.arn}"
  image_id                    = "${var.ami_image}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.keypair}"
  user_data                   = "${element(data.ct_config.config.*.rendered, count.index)}"

  security_groups = [
    "${var.security_groups}",
    "${module.nfs.efs_security_group}",
  ]

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
  }
}

resource "aws_autoscaling_group" "cluster_autoscale" {
  count       = "${var.cluster_size}"
  name_prefix = "${var.environment_name}-rancher-autoscale-"
  depends_on  = ["aws_launch_configuration.cluster"]

  availability_zones        = "${var.availability_zones}"
  desired_capacity          = "${var.capacity}"
  force_delete              = false
  health_check_grace_period = 180
  health_check_type         = "${var.health_check_type}"
  launch_configuration      = "${element(aws_launch_configuration.cluster.*.name, count.index)}"
  max_size                  = "${var.capacity_max}"
  min_size                  = "${var.capacity_min}"
  target_group_arns         = ["${aws_alb_target_group.target_group.*.arn}"]
  termination_policies      = "${var.termination_policies}"
  vpc_zone_identifier       = "${var.subnets}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.environment_name}-rancher-autoscale"
    propagate_at_launch = true
  }
}

resource "aws_alb" "lb" {
  name = "${local.domain_slug}"

  enable_deletion_protection = false
  security_groups            = ["${var.security_groups}"]
  subnets                    = "${var.subnets}"

  tags {
    Name = "${var.environment_domain}-alb"
  }
}

resource "aws_alb_listener" "http" {
  depends_on = ["aws_alb.lb"]

  load_balancer_arn = "${aws_alb.lb.arn}"
  port              = "${var.http_port}"
  protocol          = "${var.http_protocol}"

  default_action {
    type = "redirect"

    redirect {
      port        = "${var.ssl_port}"
      protocol    = "${var.ssl_protocol}"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  depends_on = [
    "aws_alb.lb",
    "aws_alb_target_group.target_group",
  ]

  certificate_arn   = "${var.certificate_arn}"
  load_balancer_arn = "${aws_alb.lb.arn}"
  port              = "${var.ssl_port}"
  protocol          = "${var.ssl_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "target_group" {
  count       = "${length(var.vpc_ids)}"
  name_prefix = "${var.environment_name}"

  port     = "${var.http_port}"
  protocol = "${var.http_protocol}"
  vpc_id   = "${element(var.vpc_ids, count.index)}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/health"
    port                = 2379
  }

  tags {
    Name = "${local.target_group}-alb-target"
  }
}
