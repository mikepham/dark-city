variable "ami_id" {
  description = "AMI ID"
  type        = "string"
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address"
  type        = "string"
}

variable "enable_monitoring" {
  description = "Enable monitoring"
  type        = "string"
}

variable "instance_type" {
  description = "AWS Instance Type"
  type        = "string"
}

variable "keypair_name" {
  description = "AWS KeyPair name"
  type        = "string"
}

variable "max_size" {
  description = "Maximum number of VMs to create"
  type        = "string"
}

variable "min_size" {
  description = "Minimum number of VMs to create"
  type        = "string"
}

variable "name" {
  description = "Auto-Scaling Group name"
  type        = "string"
}

variable "region" {
  description = "AWS Region"
  type        = "string"
}

variable "release_channel" {
  description = "CoreOS Release Channel"
  type        = "string"
}

variable "security_groups" {
  description = "Security groups for instances"
  type        = "list"
}

variable "user_data" {
  description = "CoreOS User Data"
  type        = "string"
}

variable "volume_delete_on_termination" {
  description = "Delete volume when instance is terminated"
  type        = "string"
}

variable "volume_iops" {
  description = "Volume IOPS"
  type        = "string"
}

variable "volume_size" {
  description = "Volume size"
  type        = "string"
}

variable "volume_type" {
  description = "Volume type"
  type        = "string"
}
