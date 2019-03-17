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
