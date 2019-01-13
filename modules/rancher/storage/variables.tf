variable "environment" {
  description = "Environment Name"
  type        = "string"
}

variable "subnets" {
  description = "Subnets to attach NFS to"
  type        = "list"
}

variable "vpc_ids" {
  description = "VPCs"
  type        = "list"
}
