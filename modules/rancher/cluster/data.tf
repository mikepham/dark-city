data "aws_iam_instance_profile" "iam_ec2" {
  name = "${var.iam_profile}"
}

data "aws_route53_zone" "zone" {
  name = "${var.environment_domain_tld}."
}

data "ct_config" "config" {
  count = "${var.cluster_size}"

  content      = "${data.template_file.config_template.rendered}"
  platform     = "ec2"
  pretty_print = true

  snippets = [
    "${data.template_file.etcd.rendered}",
    "${data.template_file.ntp.rendered}",
    "${data.template_file.ntp_timer.rendered}",
    "${file("${path.module}/.files/swap.yaml")}",
    "${file("${path.module}/.files/sysctl.yaml")}",
    "${file("${path.module}/.files/updates.yaml")}",
  ]
}

data "template_file" "config_template" {
  template = "${file("${path.module}/.files/config.yaml")}"

  vars {
    environment    = "${var.environment_name}"
    startup = "${replace(var.rancher_registration_token, "sudo docker", "/usr/bin/docker")}"
  }
}

data "http" "etcd_discovery" {
  url = "https://discovery.etcd.io/new"
}

data "template_file" "etcd" {
  template = "${file("${path.module}/.files/etcd.yaml")}"

  vars {
    etcd_cluster_name = "${var.cluster_name}"
    etcd_token        = "${var.etcd_token}"
    domain_name       = "${var.environment_domain}"
    discovery_url     = "${trimspace(data.http.etcd_discovery.body)}"
  }
}

data "template_file" "ntp" {
  template = "${file("${path.module}/.files/ntp.yaml")}"

  vars {
    ntp_host = "${join(" ", var.ntp_hosts)}"
  }
}

data "template_file" "ntp_timer" {
  template = "${file("${path.module}/.files/ntp-timer.yaml")}"
}
