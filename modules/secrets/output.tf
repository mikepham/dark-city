output "secrets" {
  value = "${data.jsondecode_decode.secrets.object}"
}
