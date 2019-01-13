resource "rancher_environment" "env" {
  name = "${var.environment_name}"

  description   = "Identity Provider"
  orchestration = "cattle"
}

resource "rancher_registration_token" "member" {
  name = "member_token"

  description    = "Rancher registration token"
  environment_id = "${rancher_environment.env.id}"
}

resource "rancher_stack" "cowcheck" {
  count      = "${var.enable_services}"
  name       = "cowcheck"
  depends_on = ["rancher_stack.route53"]

  catalog_id      = "community:cowcheck:0"
  environment_id  = "${rancher_environment.env.id}"
  finish_upgrade  = true
  scope           = "system"
  start_on_create = true
}

resource "rancher_stack" "janitor" {
  count      = "${var.enable_services}"
  name       = "janitor"
  depends_on = ["rancher_stack.route53"]

  catalog_id      = "community:janitor:4"
  environment_id  = "${rancher_environment.env.id}"
  finish_upgrade  = true
  scope           = "system"
  start_on_create = true
}

resource "rancher_stack" "route53" {
  count = "${var.enable_services}"
  name  = "route53"

  catalog_id      = "library:infra*route53:17"
  environment_id  = "${rancher_environment.env.id}"
  finish_upgrade  = true
  scope           = "system"
  start_on_create = true

  environment {
    AWS_ACCESS_KEY  = "${var.aws_access_key}"
    AWS_SECRET_KEY  = "${var.aws_secret_key}"
    ROOT_DOMAIN     = "${var.environment_domain_tld}"
    ROUTE53_ZONE_ID = "${data.aws_route53_zone.zone.id}"
  }
}

resource "rancher_stack" "nfs" {
  count = "${var.enable_remote_volumes * var.enable_services}"
  name  = "nfs"

  depends_on = [
    "module.nfs",
    "rancher_stack.route53",
  ]

  catalog_id      = "library:infra*nfs:5"
  environment_id  = "${rancher_environment.env.id}"
  finish_upgrade  = true
  scope           = "system"
  start_on_create = true

  environment {
    MOUNT_DIR     = "/"
    MOUNT_OPTS    = "rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2"
    NFS_SERVER    = "${module.nfs.efs_dns_name}"
    NFS_VERS      = "nfsvers=4.1"
    ON_REMOVE     = "purge"
    RANCHER_DEBUG = true
  }
}
