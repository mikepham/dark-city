output "rancher_environment_id" {
  depends_on = ["rancher_environment.env"]
  description = "Rancher Environment ID"
  value = "${rancher_environment.env.id}"
}
