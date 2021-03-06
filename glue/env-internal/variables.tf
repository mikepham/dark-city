variable "dns_domain_controller" {
  description = "DNS Windows Domain Controller"
  type        = "string"
}

variable "dns_hostname_alias" {
  default     = ""
  description = "Hostname alias"
  type        = "string"
}

variable "dns_record_ip" {
  description = "DNS record IP address"
  type        = "string"
}

variable "dns_record_name" {
  description = "DNS record name"
  type        = "string"
}

variable "dns_record_type" {
  description = "DNS record type"
  type        = "string"
}

variable "domain" {
  description = "Domain name"
  type        = "string"
}

variable "environment" {
  description = "Environment name"
  type        = "string"
}

variable "region" {
  type = "string"
}

variable "secret_name" {
  description = "AWS Secret Manager Secret Name"
  type        = "string"
}

variable "vmware_allow_unverified_ssl" {
  description = "Allow self-signed certificates"
  type        = "string"
}
