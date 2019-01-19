module "rds" {
  source = "../../aws/rds"

  disk_size       = "${var.disk_size <= 10 ? 10 : var.disk_size}"
  disk_type       = "${var.disk_type}"
  instance_type   = "${length(var.instance_type) == 0 ? "t2.micro" : var.instance_type}"
  name            = "${length(var.name) == 0 ? "rancher" : "${var.name}-rancher"}"
  parameter_group = "${var.parameter_group}"
  password        = "${var.password}"
  type            = "${var.type}"
  type_version    = "${var.type_version}"
  username        = "${length(var.username) == 0 ? "rancher": var.username}"
}
