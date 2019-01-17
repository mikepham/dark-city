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
}

data "template_file" "rancher_template" {
  template = "${file("${path.module}/.files/config.yaml")}"

  vars {
    # discovery_url   = "${random_id.etcd_discovery.keepers.discovery_url}"
    discovery_url   = "${module.secrets.secrets["ETCD_DISCOVERY_URL"]}"
    ntp_host        = "time.nist.gov"
    rancher_db_host = "${replace(aws_db_instance.rancher.endpoint, ":3306", "")}"
    rancher_db_name = "${var.database_name}"
    rancher_db_pass = "${module.secrets.secrets["RANCHER_DATABASE_PASSWORD"]}"
    rancher_db_user = "${var.database_name}"
    swap_size       = "${var.swap_size}"
  }
}

data "external" "current_username" {
  program = ["/bin/bash", "${path.module}/.files/env.sh", "get_current_username"]
}

data "external" "update_ssh_pem" {
  program = ["/bin/bash", "${path.module}/.files/env.sh", "update_ssh_pem", "${local_file.private_key_pem.filename}"]
}

data "local_file" "current_ssh_public_key" {
  filename = "/home/${data.external.current_username.result["username"]}/.ssh/id_rsa.pub"
}

data "http" "etcd_discovery" {
  url = "https://discovery.etcd.io/new"
}
