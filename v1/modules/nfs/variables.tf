variable "enabled" {
  description = "Enable NFS Storage"
  type        = "string"
}

variable "environment" {
  description = "Environment Name"
  type        = "string"
}

variable "name" {
  description = "Name of the NFS mount"
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
