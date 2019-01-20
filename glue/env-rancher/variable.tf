variable "autoscale_associate_public_ip_address" {
  default     = true
  description = "Associated public IP address"
  type        = "string"
}

variable "autoscale_availability_zone" {
  description = "Availability Zone"
  type        = "string"
}

variable "autoscale_capacity" {
  description = "Number of machines desired"
}

variable "autoscale_capacity_max" {
  default     = 1
  description = "Maxmimum number of VMs to create"
  type        = "string"
}

variable "autoscale_capacity_min" {
  default     = 1
  description = "Minimum number of VMs to create"
  type        = "string"
}

variable "autoscale_cluster_size" {
  default     = 1
  description = "Number of AutoScaling clusters to create"
  type        = "string"
}

variable "autoscale_enable_monitoring" {
  description = "Enable instance monitoring"
  type        = "string"
}

variable "autoscale_health_check_type" {
  default     = "ELB"
  description = "Health check type"
  type        = "string"
}

variable "autoscale_iam_profile" {
  description = "IAM Profile"
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

variable "autoscale_target_port" {
  default     = 80
  description = "Target Group Port"
  type        = "string"
}

variable "autoscale_target_protocol" {
  default     = "HTTP"
  description = "Target Group Protocol"
  type        = "string"
}

variable "autoscale_target_health_path" {
  default     = "/"
  description = "Target Group Health Path"
  type        = "string"
}

variable "autoscale_target_health_port" {
  default     = 80
  description = "Target Group Health Port"
  type        = "string"
}

variable "autoscale_termination_policies" {
  default     = ["OldestInstance"]
  description = "Termination Policies"
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

variable "autoscale_wait_for_elb_capacity" {
  default     = "0"
  description = "Waits for the load balancers to appear healthy as well"
  type        = "string"
}

variable "do_backups" {
  description = "Enable backups"
  type        = "string"
}

variable "do_count" {
  description = "Number of droplets to create"
  type        = "string"
}

variable "do_image" {
  description = "OS Image"
  type        = "string"
}

variable "do_ipv6" {
  description = "Enable IPv6"
  type        = "string"
}

variable "do_monitoring" {
  description = "Enable monitoring"
  type        = "string"
}

variable "do_name" {
  description = "Droplet name"
  type        = "string"
}

variable "do_private_networking" {
  description = "Enable private networking"
  type        = "string"
}

variable "do_region" {
  description = "Region"
  type        = "string"
}

variable "do_resize_disk" {
  description = "Allow resizing disk when resizing droplet"
  type        = "string"
}

variable "do_ssh_keys" {
  description = "SSH Keys"
  type        = "list"
}

variable "do_size" {
  description = "Droplet size"
  type        = "string"
}

variable "do_tags" {
  description = "Droplet tags"
  type        = "list"
}

variable "do_volume_ids" {
  description = "Volume to attach"
  type        = "list"
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

variable "efs_enabled" {
  default = true
  type    = "string"
}

variable "environment" {
  description = "Environment Name"
  type        = "string"
}

variable "rds_disk_size" {
  description = ""
  type        = "string"
}

variable "rds_instance_type" {
  description = ""
  type        = "string"
}

variable "rds_parameter_group" {
  description = ""
  type        = "string"
}

variable "rds_type" {
  description = ""
  type        = "string"
}

variable "rds_type_version" {
  description = ""
  type        = "string"
}

variable "rds_password" {
  default     = ""
  description = ""
  type        = "string"
}

variable "rds_username" {
  description = ""
  type        = "string"
}

variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = "string"
}

variable "subnets" {
  description = "Subnets"
  type        = "list"
}

variable "vpc_id" {
  description = "AWS VPC"
  type        = "string"
}
