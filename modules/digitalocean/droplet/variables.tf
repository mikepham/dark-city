variable "backups" {
  description = "Enable backups"
  type        = "string"
}

variable "count" {
  description = "Number of droplets to create"
  type        = "string"
}

variable "image" {
  description = "OS image to use"
  type        = "string"
}

variable "ipv6" {
  description = "Enable IPv6"
  type        = "string"
}

variable "monitoring" {
  description = "Monitoring"
  type        = "string"
}

variable "name" {
  description = "Name of droplet"
  type        = "string"
}

variable "private_networking" {
  description = "Enable private networking"
  type        = "string"
}

variable "region" {
  description = "Region of droplet"
  type        = "string"
}

variable "resize_disk" {
  description = "Allow resizing disk when resizing droplet"
  type        = "string"
}

variable "ssh_keys" {
  description = "SSH Keys"
  type        = "list"
}

variable "size" {
  description = "Size of droplet"
  type        = "string"
}

variable "tags" {
  description = "Tags to apply to droplet"
  type        = "list"
}

variable "user_data" {
  description = "User data"
  type        = "string"
}

variable "volume_ids" {
  description = "Volumes to attach"
  type        = "list"
}
