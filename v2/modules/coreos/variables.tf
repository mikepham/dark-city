variable "cluster_size" {
  description = "Cluster size. Musst be a value divisible by 3, 5, or 7 for a quorum"
  type        = "string"
}

variable "enable_clustering" {
  description = "Enable Clustering"
  type        = "string"
}

variable "enable_etcd" {
  description = "Enables ETCD Configuration"
  type        = "string"
}

variable "enable_ntp" {
  description = "Enables the NTP service"
  type        = "string"
}

variable "reboot_group" {
  description = "Group to assign reboots to in order to maintain quorum"
}

variable "reboot_strategy" {
  description = "Determines how updates are applied"
}

variable "release_channel" {
  default     = "stable"
  description = "CoreOS Release Channel"
  type        = "string"
}

variable "ntp_host" {
  default     = "time.nist.gov"
  description = "NTP time server"
}

variable "swap_size" {
  description = "Swap size"
  type        = "string"
}
