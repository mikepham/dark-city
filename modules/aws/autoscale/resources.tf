resource "aws_launch_configuration" "configuration" {
  name_prefix = "${var.name}-"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  enable_monitoring           = "${var.enable_monitoring}"
  iam_instance_profile        = "${data.aws_iam_instance_profile.profile.arn}"
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.keypair_name}"
  security_groups             = ["${var.security_groups}"]
  user_data                   = "${var.user_data}"

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
  count       = "${var.cluster_size}"
  name_prefix = "${var.name}-"

  depends_on = [
    "aws_alb_target_group.target_group",
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
  target_group_arns         = ["${aws_alb_target_group.target_group.*.arn}"]
  termination_policies      = "${var.termination_policies}"
  vpc_zone_identifier       = "${var.subnets}"
  wait_for_elb_capacity     = "${var.wait_for_elb_capacity}"
}

resource "aws_alb_target_group" "target_group" {
  count = "${var.cluster_size}"

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

resource "aws_security_group" "etcd" {
  name_prefix = "${var.name}-security-etcd-"

  description = "Allows etcd traffic from instances within the VPC."
  vpc_id      = "${data.aws_vpc.vpc.id}"

  ingress {
    from_port = 2379
    to_port   = 2379
    protocol  = "tcp"

    cidr_blocks = ["${data.aws_vpc.vpc.cidr_block}"]
  }

  ingress {
    from_port = 2380
    to_port   = 2380
    protocol  = "tcp"

    cidr_blocks = ["${data.aws_vpc.vpc.cidr_block}"]
  }

  tags {
    Name = "${var.name}-security-etcd"
  }
}

resource "aws_security_group" "member" {
  name_prefix = "${var.name}-security-web-"

  description = "Allows Web public traffic."
  vpc_id      = "${data.aws_vpc.vpc.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}-security"
  }
}
