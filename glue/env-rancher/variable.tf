variable "autoscale_agent_associate_public_ip_address" {
  default     = true
  description = "Associated public IP address"
  type        = "string"
}

variable "autoscale_agent_availability_zone" {
  description = "Availability Zone"
  type        = "string"
}

variable "autoscale_agent_capacity" {
  description = "Number of machines desired"
}

variable "autoscale_agent_capacity_max" {
  default     = 1
  description = "Maxmimum number of VMs to create"
  type        = "string"
}

variable "autoscale_agent_capacity_min" {
  default     = 1
  description = "Minimum number of VMs to create"
  type        = "string"
}

variable "autoscale_agent_cluster_size" {
  default     = 1
  description = "Number of AutoScaling clusters to create"
  type        = "string"
}

variable "autoscale_agent_enable_monitoring" {
  description = "Enable instance monitoring"
  type        = "string"
}

variable "autoscale_agent_health_check_type" {
  default     = "ELB"
  description = "Health check type"
  type        = "string"
}

variable "autoscale_agent_iam_profile" {
  description = "IAM Profile"
  type        = "string"
}

variable "autoscale_agent_instance_type" {
  default     = "t2.micro"
  description = "AWS Instance Type"
  type        = "string"
}

variable "autoscale_agent_keypair_name" {
  default     = ""
  description = "AWS KeyPair name"
  type        = "string"
}

variable "autoscale_agent_release_channel" {
  default     = "stable"
  description = "CoreOS Release Channel"
  type        = "string"
}

variable "autoscale_agent_security_groups" {
  default     = []
  description = "Security groups for instances"
  type        = "list"
}

variable "autoscale_agent_target_port" {
  default     = 80
  description = "Target Group Port"
  type        = "string"
}

variable "autoscale_agent_target_protocol" {
  default     = "HTTP"
  description = "Target Group Protocol"
  type        = "string"
}

variable "autoscale_agent_target_health_path" {
  default     = "/"
  description = "Target Group Health Path"
  type        = "string"
}

variable "autoscale_agent_target_health_port" {
  default     = 80
  description = "Target Group Health Port"
  type        = "string"
}

variable "autoscale_agent_termination_policies" {
  default     = ["OldestInstance"]
  description = "Termination Policies"
  type        = "list"
}

variable "autoscale_agent_volume_delete_on_termination" {
  default     = true
  description = "Delete volume when instance is terminated"
  type        = "string"
}

variable "autoscale_agent_volume_iops" {
  default     = 100
  description = "Volume IOPS"
  type        = "string"
}

variable "autoscale_agent_volume_size" {
  description = "Volume size"
  type        = "string"
}

variable "autoscale_agent_volume_type" {
  default     = "gp2"
  description = "Volume type"
  type        = "string"
}

variable "autoscale_agent_wait_for_elb_capacity" {
  default     = "0"
  description = "Waits for the load balancers to appear healthy as well"
  type        = "string"
}

variable "autoscale_server_associate_public_ip_address" {
  default     = true
  description = "Associated public IP address"
  type        = "string"
}

variable "autoscale_server_availability_zone" {
  description = "Availability Zone"
  type        = "string"
}

variable "autoscale_server_capacity" {
  description = "Number of machines desired"
}

variable "autoscale_server_capacity_max" {
  default     = 1
  description = "Maxmimum number of VMs to create"
  type        = "string"
}

variable "autoscale_server_capacity_min" {
  default     = 1
  description = "Minimum number of VMs to create"
  type        = "string"
}

variable "autoscale_server_cluster_size" {
  default     = 1
  description = "Number of AutoScaling clusters to create"
  type        = "string"
}

variable "autoscale_server_enable_monitoring" {
  description = "Enable instance monitoring"
  type        = "string"
}

variable "autoscale_server_health_check_type" {
  default     = "ELB"
  description = "Health check type"
  type        = "string"
}

variable "autoscale_server_iam_profile" {
  description = "IAM Profile"
  type        = "string"
}

variable "autoscale_server_instance_type" {
  default     = "t2.micro"
  description = "AWS Instance Type"
  type        = "string"
}

variable "autoscale_server_keypair_name" {
  default     = ""
  description = "AWS KeyPair name"
  type        = "string"
}

variable "autoscale_server_release_channel" {
  default     = "stable"
  description = "CoreOS Release Channel"
  type        = "string"
}

variable "autoscale_server_security_groups" {
  default     = []
  description = "Security groups for instances"
  type        = "list"
}

variable "autoscale_server_target_port" {
  default     = 80
  description = "Target Group Port"
  type        = "string"
}

variable "autoscale_server_target_protocol" {
  default     = "HTTP"
  description = "Target Group Protocol"
  type        = "string"
}

variable "autoscale_server_target_health_path" {
  default     = "/"
  description = "Target Group Health Path"
  type        = "string"
}

variable "autoscale_server_target_health_port" {
  default     = 80
  description = "Target Group Health Port"
  type        = "string"
}

variable "autoscale_server_termination_policies" {
  default     = ["OldestInstance"]
  description = "Termination Policies"
  type        = "list"
}

variable "autoscale_server_volume_delete_on_termination" {
  default     = true
  description = "Delete volume when instance is terminated"
  type        = "string"
}

variable "autoscale_server_volume_iops" {
  default     = 100
  description = "Volume IOPS"
  type        = "string"
}

variable "autoscale_server_volume_size" {
  description = "Volume size"
  type        = "string"
}

variable "autoscale_server_volume_type" {
  default     = "gp2"
  description = "Volume type"
  type        = "string"
}

variable "autoscale_server_wait_for_elb_capacity" {
  default     = "0"
  description = "Waits for the load balancers to appear healthy as well"
  type        = "string"
}

variable "domain" {
  description = "Primary Environment Domain Name"
  type        = "string"
}

variable "coreos_agent_cluster_size" {
  description = "CoreOS Cluster Size"
  type        = "string"
}

variable "coreos_agent_enable_etcd" {
  default     = false
  description = "Enable the CoreOS ETCD service"
  type        = "string"
}

variable "coreos_agent_enable_ntp" {
  default     = false
  description = "Enable the CoreOS NTP service"
  type        = "string"
}

variable "coreos_agent_reboot_group" {
  default     = "loosies"
  description = "Determines reboot order to maintain quorum"
  type        = "string"
}

variable "coreos_agent_reboot_strategy" {
  default     = "off"
  description = "CoreOS Reboot Strategy"
  type        = "string"
}

variable "coreos_agent_swap_size" {
  default     = 2
  description = "Swap size"
  type        = "string"
}

variable "coreos_server_cluster_size" {
  description = "CoreOS Cluster Size"
  type        = "string"
}

variable "coreos_server_enable_etcd" {
  default     = false
  description = "Enable the CoreOS ETCD service"
  type        = "string"
}

variable "coreos_server_enable_ntp" {
  default     = false
  description = "Enable the CoreOS NTP service"
  type        = "string"
}

variable "coreos_server_reboot_group" {
  default     = "loosies"
  description = "Determines reboot order to maintain quorum"
  type        = "string"
}

variable "coreos_server_reboot_strategy" {
  default     = "off"
  description = "CoreOS Reboot Strategy"
  type        = "string"
}

variable "coreos_server_swap_size" {
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
