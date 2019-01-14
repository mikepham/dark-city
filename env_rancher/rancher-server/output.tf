output "rancher_keypair_pem" {
  value = ["${tls_private_key.rancher.*.private_key_pem}"]
}
