resource "aws_db_instance" "database" {
  name = "${var.name}"

  allocated_storage         = "${var.disk_size}"
  apply_immediately         = true
  engine                    = "${var.type}"
  engine_version            = "${var.type_version}"
  final_snapshot_identifier = "final-snapshot-${var.name}"
  instance_class            = "${var.instance_type}"
  password                  = "${var.password}"
  parameter_group_name      = "${var.parameter_group}"
  username                  = "${var.username}"
  skip_final_snapshot       = true
  storage_type              = "${var.disk_type}"
  vpc_security_group_ids    = ["${var.security_groups}"]
}
