output "ignition" {
  value = "${data.ct_config.config.rendered}"
}

output "latest_hvm" {
  value = "${data.http.coreos_manifest.body}"
}
