variable "environment" {
  description = "Environment Name"
  type        = "string"
}

variable "security_groups" {
  description = "AWS Security Groups"
  type        = "list"
}

variable "subnets" {
  description = "Subnets to attach NFS to"
  type        = "list"
}
