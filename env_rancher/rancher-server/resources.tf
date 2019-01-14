resource "tls_private_key" "rancher" {
  count = "${local.create_key_pair}"

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "rancher" {
  count = "${local.create_key_pair}"

  key_name_prefix = "rancher-${local.domain_slug}-"
  public_key      = "${tls_private_key.rancher.public_key_openssh}"
}

resource "aws_security_group" "rancher" {
  name = "rancher-security"

  description = "Allows Rancher traffic from instances within the VPC."
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

resource "aws_security_group" "rancher_cluster" {
  name = "rancher-security-cluster"

  description = "Allows Rancher HA traffic from instances within the VPC."
  vpc_id      = "${data.aws_vpc.vpc.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9345
    to_port   = 9345
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  tags {
    Name = "rancher-security-cluster"
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

resource "aws_db_instance" "rancher" {
  name = "${var.database_name}"

  allocated_storage          = "${var.disk_size}"
  apply_immediately          = "${var.apply_immediately}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  engine                     = "${var.engine}"
  engine_version             = "${var.engine_version}"
  final_snapshot_identifier  = "${var.final_snapshot_identifier}"
  identifier_prefix          = "${var.database_name}-${local.domain_slug}-"
  instance_class             = "${var.database_instance_type}"
  password                   = "${module.secrets.secrets["RANCHER_DATABASE_PASSWORD"]}"
  parameter_group_name       = "${var.parameter_group}"
  publicly_accessible        = "${var.publicly_accessible}"
  skip_final_snapshot        = "${var.skip_final_snapshot}"

  # snapshot_identifier        = "${aws_db_snapshot.before_upgrade.id}"
  storage_type           = "${var.storage_type}"
  username               = "${var.database_name}"
  vpc_security_group_ids = ["${aws_security_group.rancher_database.id}"]

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Product         = "Rancher"
    ProductInstance = "${var.database_name}"
    ProductRole     = "Database"
  }
}

resource "aws_launch_configuration" "rancher" {
  count       = "${var.cluster_size}"
  name_prefix = "${var.database_name}-configuration-"

  depends_on = [
    "aws_security_group.rancher",
    "aws_security_group.rancher_database",
  ]

  associate_public_ip_address = true
  enable_monitoring           = true

  iam_instance_profile = "${data.aws_iam_instance_profile.iam_ec2.arn}"
  image_id             = "${var.ami_image}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.keypair != "" ? var.keypair : join("", aws_key_pair.rancher.*.key_name)}"
  user_data            = "${data.ct_config.config.rendered}"

  security_groups = [
    "${aws_security_group.rancher.id}",
    "${aws_security_group.rancher_database.id}",
    "${aws_security_group.rancher_cluster.id}",
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

resource "aws_autoscaling_group" "rancher_autoscale" {
  count       = "${var.cluster_size}"
  name_prefix = "${var.database_name}-autoscale-"

  depends_on = [
    "aws_alb_target_group.target_group",
    "aws_db_instance.rancher",
    "aws_launch_configuration.rancher",
  ]

  availability_zones        = ["${var.availability_zone}"]
  desired_capacity          = "${var.capacity}"
  force_delete              = false
  health_check_grace_period = 180
  health_check_type         = "${var.iam_profile}"
  launch_configuration      = "${aws_launch_configuration.rancher.name}"
  max_size                  = "${var.capacity_max}"
  min_size                  = "${var.capacity_min}"
  target_group_arns         = ["${aws_alb_target_group.target_group.*.arn}"]
  termination_policies      = ["${var.termination_policies}"]
  vpc_zone_identifier       = "${var.subnets}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.database_name}-autoscale"
    propagate_at_launch = true
  }
}

resource "aws_alb" "lb" {
  name = "${var.database_name}-${local.domain_slug}"

  depends_on = [
    "aws_security_group.rancher",
    "aws_security_group.rancher_database",
  ]

  enable_deletion_protection = "${var.enable_delete_protection}"
  subnets                    = "${var.subnets}"

  security_groups = [
    "${aws_security_group.rancher.id}",
    "${aws_security_group.rancher_database.id}",
  ]

  tags {
    Name = "${var.database_name}-alb"
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
    path                = "/v1/scripts/api.crt"
    port                = 80
  }

  tags {
    Name = "rancher-alb-target"
  }
}

resource "aws_route53_record" "rancher" {
  name = "rancher.${var.domain}"

  type    = "A"
  zone_id = "${data.aws_route53_zone.zone.id}"

  alias {
    evaluate_target_health = true
    name                   = "${aws_alb.lb.dns_name}"
    zone_id                = "${aws_alb.lb.zone_id}"
  }
}
