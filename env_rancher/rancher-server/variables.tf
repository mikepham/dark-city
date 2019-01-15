variable "apply_immediately" {
  default = true
}

variable "ami_image" {}

variable "auto_minor_version_upgrade" {
  default = true
}

variable "availability_zone" {
  type = "string"
}

variable "capacity" {
  default = 1
}

variable "capacity_max" {
  default = 1
}

variable "capacity_min" {
  default = 1
}

variable "cluster_size" {
  default = 1
}

variable "database_instance_type" {
  type = "string"
}

variable "database_name" {
  default = "rancher"
}

variable "disk_size" {
  default = 10
}

variable "domain" {}

variable "enable_delete_protection" {
  default = true
  type    = "string"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "final_snapshot_identifier" {
  default = "final-snapshot-rancher"
}

variable "iam_profile" {
  default = "EC2"
}

variable "instance_type" {
  type = "string"
}

variable "keypair" {
  default = ""
}

variable "parameter_group" {
  default = "default.mysql5.7"
}

variable "publicly_accessible" {
  default = false
}

variable "skip_final_snapshot" {
  default = true
}

variable "storage_type" {
  default = "gp2"
}

variable "subnets" {
  type = "list"
}

variable "swap_size" {
  type = "string"
}

variable "termination_policies" {
  default = ["OldestInstance"]
  type    = "list"
}

variable "volume_size" {}

variable "volume_type" {
  default = "gp2"
}

variable "vpc_id" {}
