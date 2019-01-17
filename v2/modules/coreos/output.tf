output "ami_id" {
  value = "${trimspace(data.http.coreos_manifest.body)}"
}

output "user_data" {
  value = "${data.ct_config.config.rendered}"
}
