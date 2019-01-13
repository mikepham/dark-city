variable "ami_image" {}

variable "availability_zones" {
  type = "list"
}

variable "cluster_size" {
  default = 1
}

variable "domain" {}

variable "iam_profile" {
  default = "EC2"
}

variable "instance_type" {}

variable "keypair" {
  default = ""
}

variable "subnets" {
  type = "list"
}

variable "volume_size" {}

variable "volume_type" {
  default = "gp2"
}

variable "vpc_id" {}
