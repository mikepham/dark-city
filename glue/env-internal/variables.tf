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
  description = "Domain name"
  type        = "string"
}

variable "dns_domain_controller" {
  description = "DNS Windows Domain Controller"
  type        = "string"
}

variable "environment" {
  description = "Environment name"
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

variable "region" {
  description = "AWS Region"
  type        = "string"
}

variable "secret_name" {
  description = "AWS Secret Manager Secret Name"
  type        = "string"
}

variable "vmware_allow_unverified_ssl" {
  description = "Allow self-signed certificates"
  type        = "string"
}
