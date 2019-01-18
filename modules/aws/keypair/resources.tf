resource "aws_key_pair" "keypair" {
  count = "${local.create_key_pair}"

  depends_on = [
    "module.tls",
  ]

  key_name_prefix = "${var.keypair_name}"
  public_key      = "${module.tls.public_key_openssh}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "local_file" "pem" {
  depends_on = [
    "module.env",
    "module.tls",
  ]

  content  = "${join("", module.tls.private_key_pem)}"
  filename = "/home/${module.env.current_username}/.ssh/${local.pem_keypair_name}"
}
