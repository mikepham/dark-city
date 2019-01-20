output "fingerprint" {
  value = "${digitalocean_ssh_key.ssh.fingerprint}"
}

output "id" {
  value = "${digitalocean_ssh_key.ssh.id}"
}
