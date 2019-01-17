resource "tls_private_key" "tls" {
  count = "${local.create_key_pair}"

  algorithm = "${var.algorithm}"
  rsa_bits  = "${var.rsa_bits}"
}

resource "aws_key_pair" "keypair" {
  count = "${local.create_key_pair}"

  depends_on = [
    "tls_private_key.tls",
  ]

  key_name_prefix = "${var.keypair_name}-"
  public_key      = "${tls_private_key.tls.public_key_openssh}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "local_file" "pem" {
  depends_on = [
    "aws_key_pair.keypair",
    "module.env",
    "tls_private_key.tls",
  ]

  content  = "${join("", tls_private_key.tls.*.private_key_pem)}"
  filename = "/home/${module.env.current_username}/.ssh/${local.pem_filename}"
}
