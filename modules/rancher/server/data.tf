data "template_file" "rancher" {
  template = "${file("${path.module}/.files/rancher.yaml")}"

  vars {
    rancher_db_host = "${module.rds.endpoint}"
    rancher_db_name = "${var.name}"
    rancher_db_pass = "${var.password}"
    rancher_db_user = "${var.username}"
  }
}
