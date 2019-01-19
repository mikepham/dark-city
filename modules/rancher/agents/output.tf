output "ignition" {
  value = "${data.template_file.rancher_agent.rendered}"
}
