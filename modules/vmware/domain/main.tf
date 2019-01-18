provider "windns" {
  server   = "${var.domain_controller}"
  username = "${var.username}"
  password = "${var.password}"
  usessl   = true
}
