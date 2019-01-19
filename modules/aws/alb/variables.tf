variable "certificate_arn" {
  description = "Description ARN"
  type        = "string"
}

variable "domain_slug" {
  description = "Domain name slug"
  type        = "string"
}

variable "listener_port" {
  default     = 80
  description = "Load balancer listening port"
  type        = "string"
}

variable "listener_protocol" {
  default     = "HTTP"
  description = "Load balancer listening protocol"
  type        = "string"
}

variable "listener_secure_port" {
  default     = 443
  description = "Load balancer listening secure port"
  type        = "string"
}

variable "listener_secure_protocol" {
  default     = "HTTPS"
  description = "Load balancer listening secure protocol"
  type        = "string"
}

variable "name" {
  description = "Name"
  type        = "string"
}

variable "security_groups" {
  description = "AWS Security Groups"
  type        = "list"
}

variable "subnets" {
  description = "Subnets"
  type        = "list"
}

variable "target_group_arns" {
  description = "Target groups to attach"
  type        = "list"
}
