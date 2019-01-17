output "current_username" {
  value = "${data.external.current_username.result["username"]}"
}
