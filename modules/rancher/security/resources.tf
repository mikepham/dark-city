resource "aws_security_group" "member" {
  name_prefix = "${var.environment_name}-member-security-"

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
    Name        = "${var.environment_name}-member-security"
    rancher_env = "${var.environment_name}"
  }
}

resource "aws_security_group" "member_database" {
  name_prefix = "${var.environment_name}-member-security-database-"

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
    Name        = "${var.environment_name}-member-security-database"
    rancher_env = "${var.environment_name}"
  }
}

resource "aws_security_group" "etcd" {
  name_prefix = "${var.environment_name}-member-security-etcd-"

  description = "Allows etcd traffic from instances within the VPC."
  vpc_id      = "${data.aws_vpc.vpc.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 2379
    to_port   = 2379
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  ingress {
    from_port = 2380
    to_port   = 2380
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.vpc.cidr_block}",
    ]
  }

  tags {
    Name        = "${var.environment_name}-member-security-etcd"
    rancher_env = "${var.environment_name}"
  }
}
