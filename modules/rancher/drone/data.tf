data "null_data_source" "dsn" {
  depends_on = ["aws_db_instance.drone"]

  inputs = {
    dsn = "${var.database_name}:${var.database_password}@tcp(${aws_db_instance.drone.address}:3306)/${var.database_name}?parseTime=true"
  }
}

data "template_file" "drone_docker_compose" {
  template = "${file("${path.module}/.files/drone_docker-compose.yaml")}"

  vars {
    drone_admin                = "${join(",", var.admin_accounts)}"
    drone_database_dsn         = "${data.null_data_source.dsn.outputs["dns"]}"
    drone_database_type        = "${var.database_type}"
    drone_github_client        = "${var.github_client}"
    drone_github_organizations = "${join(",",var.github_organizations)}"
    drone_github_secret        = "${var.github_secret}"
    drone_image_tag            = "${var.image_tag}"
    drone_shared_secret        = "${var.shared_secret}"
    drone_url                  = "https://drone.${var.environment_domain}"
  }
}

data "template_file" "drone_rancher_compose" {
  template = "${file("${path.module}/.files/drone_rancher-compose.yaml")}"
}
