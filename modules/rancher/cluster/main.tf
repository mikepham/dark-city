module "nfs" {
  enabled = true
  source  = "../nfs"

  environment = "${var.environment_name}"
  name        = "etcd-${var.cluster_name}"
  subnets     = "${var.subnets}"
  vpc_ids     = "${var.vpc_ids}"
}
