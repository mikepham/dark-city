resource "rancher_stack" "drone" {
  count      = "${var.enabled}"
  name       = "${var.environment}-drone"
  depends_on = ["aws_db_instance.drone"]

  docker_compose  = "${data.template_file.drone_docker_compose.rendered}"
  rancher_compose = "${data.template_file.drone_rancher_compose.rendered}"
  environment_id  = "${var.environment_id}"
  finish_upgrade  = true
  scope           = "user"
  start_on_create = true
}

resource "aws_db_instance" "drone" {
  count = "${var.enabled}"
  name  = "drone"

  allocated_storage         = "${var.database_disk_size}"
  apply_immediately         = true
  engine                    = "${var.database_type}"
  engine_version            = "${var.database_type_version}"
  final_snapshot_identifier = "final-snapshot-drone-${var.environment}"
  instance_class            = "${var.database_instance_type}"
  password                  = "${var.database_password}"
  parameter_group_name      = "${var.database_parameter_group}"
  username                  = "${var.database_username}"
  skip_final_snapshot       = true
  storage_type              = "${var.database_disk_type}"
  vpc_security_group_ids    = ["${var.database_security_groups}"]
}
