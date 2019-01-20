resource "digitalocean_ssh_key" "ssh" {
  name       = "${var.name}"
  public_key = "${length(var.public_key) == 0 ? module.tls.public_key_pem : var.public_key}"
}
