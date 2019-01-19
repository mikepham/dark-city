variable "disk_size" {
  description = "Disk size"
  type        = "string"
}

variable "disk_type" {
  description = "Disk type"
  type        = "string"
}

variable "instance_type" {
  description = "Instance type"
  type        = "string"
}

variable "name" {
  description = "Database name"
  type        = "string"
}

variable "password" {
  description = "Database password"
  type        = "string"
}

variable "parameter_group" {
  description = "Database parameters"
  type        = "string"
}

variable "security_groups" {
  default     = []
  description = "Security Groups"
  type        = "list"
}

variable "type" {
  description = "Database type"
  type        = "string"
}

variable "type_version" {
  description = "Database version"
  type        = "string"
}

variable "username" {
  description = "Database username"
  type        = "string"
}
