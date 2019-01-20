resource "digitalocean_droplet" "droplet" {
  count = "${var.count}"
  name  = "${var.name}-${count.index}"

  backups            = "${var.backups}"
  image              = "${var.image}"
  ipv6               = "${var.ipv6}"
  monitoring         = "${var.monitoring}"
  private_networking = "${var.private_networking}"
  region             = "${var.region}"
  resize_disk        = "${var.resize_disk}"
  ssh_keys           = "${var.ssh_keys}"
  size               = "${var.size}"
  tags               = "${var.tags}"
  user_data          = "${var.user_data}"
  volume_ids         = "${var.volume_ids}"
}
