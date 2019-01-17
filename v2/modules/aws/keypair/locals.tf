locals {
  create_key_pair  = "${length(var.keypair_name) == 0 ? 1 : 0}"
  keypair_names    = "${join("", aws_key_pair.keypair.*.key_name)}"
  pem_filename     = "${local.pem_keypair_name}.pem"
  pem_keypair_name = "${length(local.keypair_names) == 0 ? var.keypair_name : local.keypair_names}"
}
