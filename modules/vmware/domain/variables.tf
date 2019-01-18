variable "domain" {
  description = "Zone record for domain"
  type        = "string"
}

variable "environment" {
  default     = ""
  description = "Environment name"
  type        = "string"
}

variable "hostname_alias" {
  description = "Hostname alias"
  type        = "string"
}

variable "record_ip" {
  description = "DNS IP address"
  type        = "string"
}

variable "record_name" {
  description = "Record value to create"
  type        = "string"
}

variable "record_type" {
  description = "Record type to create"
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
