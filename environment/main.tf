locals {
  domain = "${var.rancher_environment}.${var.rancher_environment_domain}"
}

#------------------------------------------------------------------------------
# Modules
#------------------------------------------------------------------------------
module "certificates" {
  source = "../modules/certificates"

  domain = "${var.rancher_certificate_domain}"
}

module "rancher" {
  source = "../modules/rancher"

  access_key                             = "${module.secrets.secrets["RANCHER_ACCESS_KEY"]}"
  ami_image                              = "${var.rancher_ami_image}"
  aws_access_key                         = "${module.secrets.secrets["AWS_ACCESS_KEY"]}"
  aws_secret_key                         = "${module.secrets.secrets["AWS_SECRET_KEY"]}"
  availability_zones                     = "${var.rancher_availability_zones}"
  capacity                               = "${var.rancher_capacity}"
  capacity_max                           = "${var.rancher_capacity_max}"
  capacity_min                           = "${var.rancher_capacity_min}"
  certificate_arn                        = "${module.certificates.aws_certificate_arn}"
  cluster_name                           = "${var.rancher_environment}"
  cluster_size                           = "${var.rancher_cluster_size}"
  cluster_member_size                    = "${var.rancher_cluster_member_size}"
  drone_admin_accounts                   = "${var.drone_admin_accounts}"
  drone_database_disk_size               = "${var.drone_database_disk_size}"
  drone_database_instance_type           = "${var.drone_database_instance_type}"
  drone_database_name                    = "${var.drone_database_name}"
  drone_database_parameter_group         = "${var.drone_database_parameter_group}"
  drone_database_password                = "${module.secrets.secrets["DRONE_DATABASE_PASSWORD"]}"
  drone_database_username                = "${var.drone_database_username}"
  drone_database_type                    = "${var.drone_database_type}"
  drone_database_type_version            = "${var.drone_database_type_version}"
  drone_enabled                          = "${var.drone_enabled}"
  drone_github_client                    = "${module.secrets.secrets["DRONE_GITHUB_CLIENT"]}"
  drone_github_organizations             = "${var.drone_github_organizations}"
  drone_github_secret                    = "${module.secrets.secrets["DRONE_GITHUB_SECRET"]}"
  drone_image_tag                        = "${var.drone_image_tag}"
  drone_shared_secret                    = "${module.secrets.secrets["DRONE_SECRET"]}"
  elasticsearch_dedicated_master_count   = "${var.elasticsearch_dedicated_master_count}"
  elasticsearch_dedicated_master_enabled = "${var.elasticsearch_dedicated_master_enabled}"
  elasticsearch_dedicated_master_type    = "${var.elasticsearch_dedicated_master_type}"
  elasticsearch_enabled                  = "${var.elasticsearch_enabled}"
  elasticsearch_encrypt_at_rest          = "${var.elasticsearch_encrypt_at_rest}"
  elasticsearch_instance_count           = "${var.elasticsearch_instance_count}"
  elasticsearch_instance_type            = "${var.elasticsearch_instance_type}"
  elasticsearch_node2node_encryption     = "${var.elasticsearch_node2node_encryption}"
  elasticsearch_snapshot_start_hour      = "${var.elasticsearch_snapshot_start_hour}"
  elasticsearch_subnets                  = "${var.rancher_subnets}"
  elasticsearch_version                  = "${var.elasticsearch_version}"
  elasticsearch_volume_size              = "${var.elasticsearch_volume_size}"
  elasticsearch_volume_type              = "${var.elasticsearch_volume_type}"
  elasticsearch_zone_awareness_enabled   = "${var.elasticsearch_zone_awareness_enabled}"
  enable_services                        = "${var.rancher_enable_services}"

  # etcd_discovery_url                     = "${module.secrets.secrets["ETCD_DISCOVERY_URL"]}"
  etcd_token              = "${var.rancher_etcd_token}"
  environment_domain      = "${local.domain}"
  environment_domain_tld  = "${var.rancher_environment_domain}"
  environment_name        = "${var.rancher_environment}"
  environment_rancher_url = "${var.rancher_url}"
  iam_profile             = "${var.rancher_iam_profile}"
  instance_type           = "${var.rancher_instance_type}"
  keypair                 = "${var.rancher_keypair}"
  monitoring              = "${var.rancher_monitoring}"
  ntp_hosts               = "${var.rancher_ntp_hosts}"
  secret_key              = "${module.secrets.secrets["RANCHER_SECRET_KEY"]}"
  subnets                 = "${var.rancher_subnets}"
  use_public_ip           = "${var.rancher_use_public_ip}"
  volume_size             = "${var.rancher_volume_size}"
  vpc_ids                 = "${var.rancher_vpc_ids}"
}

module "secrets" {
  source = "../modules/secrets"

  secret_name = "terraform-infrastructure"
}
