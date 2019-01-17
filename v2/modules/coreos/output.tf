output "ami_id" {
  value = "${data.http.coreos_manifest.body}"
}

output "user_data" {
  value = "${data.ct_config.config.rendered}"
}
