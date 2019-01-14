data "aws_iam_instance_profile" "iam_ec2" {
  name = "${var.iam_profile}"
}

data "aws_route53_zone" "zone" {
  name = "${var.domain}."
}

data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

data "ct_config" "rancher" {
  content      = "${data.template_file.rancher_template.rendered}"
  platform     = "ec2"
  pretty_print = true

  snippets = [
    "${data.template_file.ntp.rendered}",
    "${data.template_file.ntp_timer.rendered}",
    "${file("${path.module}/.files/swap.yaml")}",
    "${file("${path.module}/.files/sysctl.yaml")}",
    "${file("${path.module}/.files/updates.yaml")}",
  ]
}

data "template_file" "rancher_template" {
  template = "${file("${path.module}/.files/config.yaml")}"

  vars {
    rancher_db_host = "${replace(aws_db_instance.rancher.endpoint, ":3306", "")}"
    rancher_db_name = "${var.database_name}"
    rancher_db_pass = "${module.secrets.secrets["RANCHER_DATABASE_PASSWORD"]}"
    rancher_db_user = "${var.database_name}"
  }
}

data "template_file" "ntp" {
  template = "${file("${path.module}/.files/ntp.yaml")}"

  vars {
    ntp_host = "time.nist.gov"
  }
}

data "template_file" "ntp_timer" {
  template = "${file("${path.module}/.files/ntp-timer.yaml")}"
}

data "external" "current_username" {
  program = ["/bin/bash", "${path.module}/.files/env.sh", "get_current_username"]
}

data "external" "update_ssh_pem" {
  program = ["/bin/bash", "${path.module}/.files/env.sh", "update_ssh_pem", "${local_file.private_key_pem.filename}"]
}
