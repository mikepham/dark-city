resource "aws_security_group" "member_storage" {
  count       = "${length(var.vpc_ids)}"
  name_prefix = "${var.environment}-member-security-storage-"
  description = "Allows NFS traffic from instances within the VPC."
  vpc_id      = "${element(var.vpc_ids, count.index)}"

  egress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    cidr_blocks = ["${element(data.aws_vpc.vpc.*.cidr_block, count.index)}"]
  }

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    cidr_blocks = ["${element(data.aws_vpc.vpc.*.cidr_block, count.index)}"]
  }

  tags {
    Name = "${var.environment}-member-security-storage"
  }
}

resource "aws_efs_file_system" "member_storage" {
  creation_token = "${var.environment}-member-storage"

  tags {
    Name = "${var.environment}-member-storage"
  }
}

resource "aws_efs_mount_target" "member_storage_mounts" {
  count = "${length(var.subnets)}"

  depends_on = [
    "aws_efs_file_system.member_storage",
    "aws_security_group.member_storage",
  ]

  file_system_id  = "${aws_efs_file_system.member_storage.id}"
  security_groups = ["${aws_security_group.member_storage.*.id}"]
  subnet_id       = "${element(var.subnets, count.index)}"
}
