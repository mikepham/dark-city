module "storage" {
  source = "../storage"

  environment = "${var.environment_name}"
  name        = "${var.cluster_name}"
  subnets     = "${var.subnets}"
  vpc_ids     = "${var.vpc_ids}"
}
