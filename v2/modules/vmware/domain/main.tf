provider "windows-dns" {
  password    = "${var.password}"
  server_name = "${var.domain_controller}"
  username    = "${var.username}"
}
