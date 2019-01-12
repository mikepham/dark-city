resource "aws_efs_file_system" "member_storage" {
  creation_token = "member-storage-${var.environment}"

  tags {
    Name        = "member-storage-${var.environment}"
    rancher_env = "${var.environment}"
  }
}

resource "aws_efs_mount_target" "member_storage_mounts" {
  depends_on = [
    "aws_efs_file_system.member_storage",
  ]

  count           = "${length(var.subnets)}"
  file_system_id  = "${aws_efs_file_system.member_storage.id}"
  security_groups = ["${var.security_groups}"]
  subnet_id       = "${element(var.subnets, count.index)}"
}
