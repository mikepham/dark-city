output "secrets" {
  depends_on  = ["data.jsondecode_decode.secrets"]
  description = "Environment Secrets"
  value       = "${data.jsondecode_decode.secrets.object}"
}
