output "ignition" {
  value = "${data.template_file.rancher.rendered}"
}
