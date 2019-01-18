variable "ami_id" {
  description = "AMI ID"
  type        = "string"
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address"
  type        = "string"
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = "string"
}

variable "capacity" {
  description = "Number of machines desired"
  type        = "string"
}

variable "capacity_max" {
  description = "Maximum number of VMs to create"
  type        = "string"
}

variable "capacity_min" {
  description = "Minimum number of VMs to create"
  type        = "string"
}

variable "enable_monitoring" {
  description = "Enable monitoring"
  type        = "string"
}

variable "health_check_type" {
  description = "Health Check Type"
  type        = "string"
}

variable "iam_profile" {
  description = "IAM Profile"
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

variable "subnets" {
  description = "Subnets"
  type        = "list"
}

variable "target_port" {
  description = "Target Group Port"
  type        = "string"
}

variable "target_protocol" {
  description = "Target Group Protocol"
  type        = "string"
}

variable "target_health_path" {
  description = "Target Group health check path"
  type        = "string"
}

variable "target_health_port" {
  description = "Target Group health check port"
  type        = "string"
}

variable "termination_policies" {
  description = "Termination Policies"
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

variable "vpc_id" {
  description = "AWS VPC"
  type        = "string"
}
