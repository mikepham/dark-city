variable "domain" {
  description = "Zone record for domain"
  type        = "string"
}

variable "environment" {
  default     = ""
  description = "Environment name"
  type        = "string"
}

variable "dns_record_type" {
  description = "Record type to create"
  type        = "string"
}

variable "dns_record_value" {
  description = "Record value to create"
  type        = "string"
}

variable "domain_controller" {
  description = "Windows Domain Controller"
  type        = "string"
}

variable "password" {
  description = "Windows Credentials"
  type        = "string"
}

variable "ttl" {
  description = "Record time-to-live duration"
  type        = "string"
}

variable "username" {
  description = "Windows Credentials"
  type        = "string"
}
