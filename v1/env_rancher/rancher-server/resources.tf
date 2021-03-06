#------------------------------------------------------------------------------
# SSH Keys
#------------------------------------------------------------------------------
resource "tls_private_key" "rancher" {
  count = "${local.create_key_pair}"

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "rancher" {
  count = "${local.create_key_pair}"

  depends_on = [
    "tls_private_key.rancher",
  ]

  key_name_prefix = "rancher-${local.domain_slug}-"
  public_key      = "${tls_private_key.rancher.public_key_openssh}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "local_file" "private_key_pem" {
  depends_on = [
    "aws_key_pair.rancher",
    "data.external.current_username",
    "tls_private_key.rancher",
  ]

  content  = "${join("", tls_private_key.rancher.*.private_key_pem)}"
  filename = "/home/${data.external.current_username.result["username"]}/.ssh/${join("", aws_key_pair.rancher.*.key_name)}.pem"
}

#------------------------------------------------------------------------------
# Security Groups
#------------------------------------------------------------------------------
resource "aws_security_group" "rancher" {
  name = "${var.database_name}-security"

  depends_on = [
    "data.aws_vpc.vpc",
  ]

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

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${var.database_name}-security"
  }
}

resource "aws_security_group" "rancher_server" {
  name = "${var.database_name}-security-server"

  depends_on = [
    "data.aws_vpc.vpc",
  ]

  description = "Allows Rancher Server traffic from instances within the VPC."
  vpc_id      = "${data.aws_vpc.vpc.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${var.database_name}-security-server"
  }
}

resource "aws_security_group" "rancher_cluster" {
  name = "${var.database_name}-security-cluster"

  depends_on = [
    "data.aws_vpc.vpc",
  ]

  description = "Allows Rancher HA traffic from instances within the VPC."
  vpc_id      = "${data.aws_vpc.vpc.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

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

  ingress {
    from_port = 9345
    to_port   = 9345
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${var.database_name}-security-cluster"
  }
}

resource "aws_security_group" "rancher_database" {
  name = "${var.database_name}-security-database"

  depends_on = [
    "data.aws_vpc.vpc",
  ]

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

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${var.database_name}-security-database"
  }
}

#------------------------------------------------------------------------------
# Database
#------------------------------------------------------------------------------
resource "aws_db_instance" "rancher" {
  name = "${var.database_name}"

  depends_on = [
    "aws_security_group.rancher_database",
    "module.secrets",
  ]

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

#------------------------------------------------------------------------------
# AutoScaling Group
#------------------------------------------------------------------------------
resource "aws_launch_configuration" "rancher" {
  count       = "${var.cluster_size}"
  name_prefix = "${var.database_name}-configuration-"

  depends_on = [
    "aws_security_group.rancher",
    "aws_security_group.rancher_cluster",
    "aws_security_group.rancher_database",
    "data.aws_iam_instance_profile.iam_ec2",
    "data.ct_config.rancher",
  ]

  associate_public_ip_address = true
  enable_monitoring           = true

  iam_instance_profile = "${data.aws_iam_instance_profile.iam_ec2.arn}"
  image_id             = "${var.ami_image}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.keypair != "" ? var.keypair : join("", aws_key_pair.rancher.*.key_name)}"
  user_data            = "${data.ct_config.rancher.rendered}"

  security_groups = [
    "${aws_security_group.rancher.id}",
    "${aws_security_group.rancher_cluster.id}",
    "${aws_security_group.rancher_database.id}",
    "${aws_security_group.rancher_server.id}",
  ]

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    delete_on_termination = true
    iops                  = "${var.volume_iops}"
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
  }
}

resource "aws_autoscaling_group" "rancher_autoscale" {
  count       = "${var.cluster_size}"
  name_prefix = "${var.database_name}-autoscale-"

  depends_on = [
    "aws_alb_target_group.target_group",
    "aws_launch_configuration.rancher",
  ]

  availability_zones        = ["${var.availability_zone}"]
  desired_capacity          = "${var.capacity}"
  force_delete              = false
  health_check_grace_period = 180
  health_check_type         = "${var.health_check_type}"
  launch_configuration      = "${aws_launch_configuration.rancher.name}"
  max_size                  = "${var.capacity_max}"
  min_size                  = "${var.capacity_min}"
  target_group_arns         = ["${element(aws_alb_target_group.target_group.*.arn, count.index)}"]
  termination_policies      = ["${var.termination_policies}"]
  vpc_zone_identifier       = "${var.subnets}"

  initial_lifecycle_hook {
    default_result       = "ABANDON"
    heartbeat_timeout    = 3600
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
    name                 = "${var.database_name}-${local.domain_slug}"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.database_name}-${local.domain_slug}-autoscale"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.database_name}"
    propagate_at_launch = true
  }
}

#------------------------------------------------------------------------------
# Load Balancer
#------------------------------------------------------------------------------
resource "aws_alb" "lb" {
  count = "${local.loadbalancer_count}"
  name  = "${var.database_name}-${local.domain_slug}"

  depends_on = [
    "aws_security_group.rancher",
  ]

  enable_deletion_protection = "${var.enable_delete_protection}"
  subnets                    = "${var.subnets}"

  lifecycle {
    create_before_destroy = true
  }

  security_groups = [
    "${aws_security_group.rancher.id}",
  ]

  tags {
    Name = "${local.domain_slug}-alb"
  }
}

resource "aws_alb_listener" "http" {
  count = "${local.loadbalancer_count}"

  depends_on = [
    "aws_alb.lb",
  ]

  load_balancer_arn = "${element(aws_alb.lb.*.arn, count.index)}"
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
  count = "${local.loadbalancer_count}"

  depends_on = [
    "aws_alb_target_group.target_group",
    "module.certificates",
  ]

  certificate_arn   = "${module.certificates.aws_certificate_arn}"
  load_balancer_arn = "${element(aws_alb.lb.*.arn, count.index)}"
  port              = 443
  protocol          = "HTTPS"

  default_action {
    target_group_arn = "${element(aws_alb_target_group.target_group.*.arn, count.index)}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "target_group" {
  count = "${var.cluster_size}"

  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/v1/scripts/api.crt"
    port                = 8080
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${var.database_name}-${local.domain_slug}-alb-target"
  }
}

#------------------------------------------------------------------------------
# DNS
#------------------------------------------------------------------------------
resource "aws_route53_record" "rancher" {
  name = "rancher.${var.domain}"

  depends_on = [
    "data.aws_route53_zone.zone",
  ]

  type    = "A"
  zone_id = "${data.aws_route53_zone.zone.id}"

  alias {
    evaluate_target_health = true
    name                   = "${aws_alb.lb.dns_name}"
    zone_id                = "${aws_alb.lb.zone_id}"
  }
}
