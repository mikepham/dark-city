#------------------------------------------------------------------------------
# Providers
#------------------------------------------------------------------------------
provider "rancher" {
  api_url    = "${var.environment_rancher_url}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  version    = "1.2.1"
}

provider "http" {
  version = "1.0"
}

provider "template" {
  version = "1.0.0"
}

#------------------------------------------------------------------------------
# Modules
#------------------------------------------------------------------------------
module "cluster" {
  source = "cluster"

  agent_startup           = "${rancher_registration_token.member.command}"
  agent_token             = "${rancher_registration_token.member.token}"
  ami_image               = "${var.ami_image}"
  availability_zones      = "${var.availability_zones}"
  capacity                = "${var.capacity}"
  capacity_max            = "${var.capacity_max}"
  capacity_min            = "${var.capacity_min}"
  certificate_arn         = "${var.certificate_arn}"
  cluster_name            = "${var.environment_name}"
  cluster_size            = "${var.cluster_size}"
  cluster_member_size     = "${var.cluster_member_size}"
  environment_name        = "${var.environment_name}"
  discovery_url           = "${var.etcd_discovery_url}"
  etcd_token              = "${var.etcd_token}"
  environment_domain      = "${var.environment_domain}"
  environment_domain_tld  = "${var.environment_domain_tld}"
  environment_name        = "${var.environment_name}"
  environment_rancher_url = "${var.environment_rancher_url}"
  iam_profile             = "${var.iam_profile}"
  instance_type           = "${var.instance_type}"
  keypair                 = "${var.keypair}"
  monitoring              = "${var.monitoring}"
  ntp_hosts               = "${var.ntp_hosts}"
  subnets                 = "${var.subnets}"
  use_public_ip           = "${var.use_public_ip}"
  volume_size             = "${var.volume_size}"
  vpc_ids                 = "${var.vpc_ids}"

  security_groups = [
    "${module.security.security_groups}",
    "${module.storage.efs_security_group}",
    "${module.elasticsearch.elasticsearch_security_group}",
  ]
}

module "drone" {
  source  = "drone"
  enabled = "${var.drone_enabled}"

  admin_accounts           = "${var.drone_admin_accounts}"
  environment              = "${var.environment_name}"
  environment_domain       = "${var.environment_domain}"
  environment_id           = "${rancher_environment.env.id}"
  database_disk_size       = "${var.drone_database_disk_size}"
  database_instance_type   = "${var.drone_database_instance_type}"
  database_name            = "${var.drone_database_name}"
  database_parameter_group = "${var.drone_database_parameter_group}"
  database_password        = "${var.drone_database_password}"
  database_security_groups = ["${module.security.security_group_database}"]
  database_type            = "${var.drone_database_type}"
  database_type_version    = "${var.drone_database_type_version}"
  database_username        = "${var.drone_database_username}"
  image_tag                = "${var.drone_image_tag}"
  github_client            = "${var.drone_github_client}"
  github_organizations     = "${var.drone_github_organizations}"
  github_secret            = "${var.drone_github_secret}"
  shared_secret            = "${var.drone_shared_secret}"
}

module "elasticsearch" {
  source = "elasticsearch"

  account_id               = "${data.aws_caller_identity.account.account_id}"
  availability_zones       = "${var.availability_zones}"
  dedicated_master_count   = "${var.elasticsearch_dedicated_master_count}"
  dedicated_master_enabled = "${var.elasticsearch_dedicated_master_enabled}"
  dedicated_master_type    = "${var.elasticsearch_dedicated_master_type}"
  domain                   = "${var.environment_domain}"
  encrypt_at_rest          = "${var.elasticsearch_encrypt_at_rest}"
  environment              = "${var.environment_name}"
  elasticsearch_version    = "${var.elasticsearch_version}"
  instance_count           = "${var.elasticsearch_instance_count}"
  instance_type            = "${var.elasticsearch_instance_type}"
  node2node_encryption     = "${var.elasticsearch_node2node_encryption}"
  snapshot_start_hour      = "${var.elasticsearch_snapshot_start_hour}"
  subnets                  = "${var.elasticsearch_subnets}"
  volume_size              = "${var.elasticsearch_volume_size}"
  volume_type              = "${var.elasticsearch_volume_type}"
  vpc_ids                  = "${var.vpc_ids}"
  zone_awareness_enabled   = "${var.elasticsearch_zone_awareness_enabled}"
}

module "security" {
  source = "security"

  environment_name = "${var.environment_name}"
  vpc_ids          = "${var.vpc_ids}"
}

module "storage" {
  source = "storage"

  environment = "${var.environment_name}"
  name        = "${var.environment_name}"
  subnets     = "${var.subnets}"
  vpc_ids     = "${var.vpc_ids}"
}
