variable "ami_id" {
  description = "AMI ID"
  type        = "string"
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address"
  type        = "string"
}

variable "instance_type" {
  description = "AWS Instance Type"
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

variable "user_data" {
  description = "CoreOS User Data"
  type        = "string"
}
