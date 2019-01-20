module "droplets" {
  source = "../../../modules/digitalocean/droplet"

  backups            = false
  count              = 3
  image              = "coreos-stable"
  ipv6               = false
  monitoring         = false
  name               = "agent"
  private_networking = false
  region             = "nyc3"
  resize_disk        = true
  ssh_keys           = []
  size               = "1gb"           # s-2vcpu-2gb
  tags               = ["internal"]
  volume_ids         = []
}