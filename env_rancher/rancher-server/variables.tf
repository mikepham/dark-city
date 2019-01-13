variable "ami_image" {}

variable "availability_zones" {
  type = "list"
}

variable "cluster_size" {
  default = 1
}

variable "domain" {}

variable "filesystem_id" {}

variable "iam_profile" {
  default = "EC2"
}

variable "instance_type" {}

variable "keypair" {}

variable "subnets" {
  type = "list"
}

variable "volume_size" {}

variable "volume_type" {}

variable "vpc_id" {}
