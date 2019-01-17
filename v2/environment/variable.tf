variable "autoscale_associate_public_ip_address" {
  default     = true
  description = "Associated public IP address"
  type        = "string"
}

variable "autoscale_instance_type" {
  default     = "t2.micro"
  description = "AWS Instance Type"
  type        = "string"
}

variable "autoscale_max_size" {
  default     = 1
  description = "Maxmimum number of VMs to create"
  type        = "string"
}

variable "autoscale_min_size" {
  default     = 1
  description = "Minimum number of VMs to create"
  type        = "string"
}

variable "domain" {
  description = "Primary Environment Domain Name"
  type        = "string"
}

variable "coreos_cluster_size" {
  description = "CoreOS Cluster Size"
  type        = "string"
}

variable "coreos_enable_etcd" {
  description = "Enable the CoreOS ETCD service"
  type        = "string"
}

variable "coreos_enable_ntp" {
  description = "Enable the CoreOS NTP service"
  type        = "string"
}

variable "coreos_reboot_group" {
  description = "Determines reboot order to maintain quorum"
  type        = "string"
}

variable "coreos_reboot_strategy" {
  description = "CoreOS Reboot Strategy"
  type        = "string"
}

variable "coreos_swap_size" {
  default     = 2
  description = "Swap size"
  type        = "string"
}

variable "environment" {
  description = "Environment Name"
  type        = "string"
}

variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = "string"
}
