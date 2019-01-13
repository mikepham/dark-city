resource "aws_security_group" "rancher" {
  name = "rancher-security"

  description = "Allows rancher traffic from instances within the VPC."
  vpc_id      = "${data.aws_vpc.vpc.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

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

  ingress {
    from_port = 500
    to_port   = 500
    protocol  = "udp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  ingress {
    from_port = 4500
    to_port   = 4500
    protocol  = "udp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  tags {
    Name = "rancher-security"
  }
}

resource "aws_security_group" "rancher_database" {
  name = "rancher-security-database"

  description = "Allows Database traffic from instances within the VPC."
  vpc_id      = "${data.aws_vpc.vpc.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 1433
    to_port   = 1433
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  tags {
    Name = "rancher-security-database"
  }
}

resource "aws_launch_configuration" "rancher" {
  name = "rancher-configuration"

  depends_on = [
    "aws_security_group.rancher",
    "aws_security_group.rancher_database",
  ]

  associate_public_ip_address = true
  enable_monitoring           = true
  iam_instance_profile        = "${data.aws_iam_instance_profile.iam_ec2.arn}"
  image_id                    = "${var.ami_image}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.keypair}"
  user_data                   = "${data.ct_config.config.rendered}"

  security_groups = [
    "${aws_security_group.rancher.id}",
    "${aws_security_group.rancher_database.id}",
  ]

  lifecycle {
    create_before_destroy = false
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
  }
}

resource "aws_autoscaling_group" "rancher_autoscale" {
  name = "rancher-autoscale"

  depends_on = [
    "aws_launch_configuration.rancher",
    "aws_alb_target_group.target_group",
  ]

  availability_zones        = "${var.availability_zones}"
  desired_capacity          = 1
  force_delete              = false
  health_check_grace_period = 180
  health_check_type         = "EC2"
  launch_configuration      = "${aws_launch_configuration.rancher.name}"
  max_size                  = 1
  min_size                  = 1
  target_group_arns         = ["${aws_alb_target_group.target_group.*.arn}"]
  termination_policies      = ["OldestInstance"]
  vpc_zone_identifier       = "${var.subnets}"

  lifecycle {
    create_before_destroy = false
  }

  tag {
    key                 = "Name"
    value               = "rancher-autoscale"
    propagate_at_launch = true
  }
}

resource "aws_alb" "lb" {
  name = "rancher-${local.domain_slug}"

  depends_on = [
    "aws_security_group.rancher",
    "aws_security_group.rancher_database",
  ]

  enable_deletion_protection = false
  subnets                    = "${var.subnets}"

  security_groups = [
    "${aws_security_group.rancher.id}",
    "${aws_security_group.rancher_database.id}",
  ]

  tags {
    Name = "rancher-alb"
  }
}

resource "aws_alb_listener" "http" {
  depends_on = ["aws_alb.lb"]

  load_balancer_arn = "${aws_alb.lb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  depends_on = [
    "aws_alb.lb",
    "aws_alb_target_group.target_group",
  ]

  certificate_arn   = "${module.certificates.aws_certificate_arn}"
  load_balancer_arn = "${aws_alb.lb.arn}"
  port              = 443
  protocol          = "HTTPS"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "target_group" {
  name = "rancher-${local.domain_slug}"

  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/ping"
    port                = 80
  }

  tags {
    Name = "rancher-alb-target"
  }
}
