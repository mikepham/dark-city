output "secrets" {
  description = "Environment Secrets"
  value = "${data.jsondecode_decode.secrets.object}"
}
