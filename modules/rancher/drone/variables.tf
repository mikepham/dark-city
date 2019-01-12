variable "admin_accounts" {
  description = "Drone Admin"
  type        = "list"
}

variable "database_disk_size" {
  description = "Database Disk Size"
  type        = "string"
}

variable "database_instance_type" {
  description = "Database Instance Type"
  type        = "string"
}

variable "database_name" {
  default = "drone"
  type    = "string"
}

variable "database_parameter_group" {
  description = "Database Parameter Group"
  type        = "string"
}

variable "database_password" {
  description = "Database Password"
  type        = "string"
}

variable "database_security_groups" {
  description = "Database Security Groups"
  type        = "list"
}

variable "database_type" {
  description = "Database Type"
  type        = "string"
}

variable "database_type_version" {
  description = "Database Type Version"
  type        = "string"
}

variable "database_username" {
  description = "Database UserName"
  type        = "string"
}

variable "enabled" {
  description = "Enable Module"
  type        = "string"
}

variable "environment" {
  description = "Environment Name"
  type        = "string"
}

variable "environment_domain" {
  description = "Environment Domain"
  type        = "string"
}

variable "environment_id" {
  description = "Environment ID"
  type        = "string"
}

variable "image_tag" {
  description = "Drone Image Docker Tag"
  type        = "string"
}

variable "github_client" {
  description = "Drone GitHub Client"
  type        = "string"
}

variable "github_organizations" {
  description = "Drone GitHub Organizations"
  type        = "list"
}

variable "github_secret" {
  description = "Drone GitHub Secret"
  type        = "string"
}

variable "shared_secret" {
  description = "Drone Shared Secret"
  type        = "string"
}
