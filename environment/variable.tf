variable "autoscale_associate_public_ip_address" {
  default     = true
  description = "Associated public IP address"
  type        = "string"
}

variable "autoscale_enable_monitoring" {
  description = "Enable instance monitoring"
  type        = "string"
}

variable "autoscale_instance_type" {
  default     = "t2.micro"
  description = "AWS Instance Type"
  type        = "string"
}

variable "autoscale_keypair_name" {
  default     = ""
  description = "AWS KeyPair name"
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

variable "autoscale_release_channel" {
  default     = "stable"
  description = "CoreOS Release Channel"
  type        = "string"
}

variable "autoscale_security_groups" {
  default     = []
  description = "Security groups for instances"
  type        = "list"
}

variable "autoscale_volume_delete_on_termination" {
  default     = true
  description = "Delete volume when instance is terminated"
  type        = "string"
}

variable "autoscale_volume_iops" {
  default     = 100
  description = "Volume IOPS"
  type        = "string"
}

variable "autoscale_volume_size" {
  description = "Volume size"
  type        = "string"
}

variable "autoscale_volume_type" {
  default     = "gp2"
  description = "Volume type"
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
  default     = false
  description = "Enable the CoreOS ETCD service"
  type        = "string"
}

variable "coreos_enable_ntp" {
  default     = false
  description = "Enable the CoreOS NTP service"
  type        = "string"
}

variable "coreos_reboot_group" {
  default     = "loosies"
  description = "Determines reboot order to maintain quorum"
  type        = "string"
}

variable "coreos_reboot_strategy" {
  default     = "off"
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