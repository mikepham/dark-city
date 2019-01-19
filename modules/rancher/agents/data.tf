data "template_file" "rancher_agent" {
  template = "${file("${path.module}/.files/rancher-agent.yaml")}"

  vars {
    startup = ""
  }
}
