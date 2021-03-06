#------------------------------------------------------------------------------
# Providers
#------------------------------------------------------------------------------
provider "http" {
  version = "1.0.0"
}

#------------------------------------------------------------------------------
# Modules
#------------------------------------------------------------------------------
module "nfs" {
  enabled = true
  source  = "../../nfs"

  environment = "${var.environment_name}"
  name        = "etcd-${var.cluster_name}"
  subnets     = "${var.subnets}"
  vpc_ids     = "${var.vpc_ids}"
}
