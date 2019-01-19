variable "certificates" {
  default     = []
  description = "Certificate domain names to create"
  type        = "list"
}

variable "domain" {
  description = "Certificate Domain Name"
  type        = "string"
}

variable "validation_method" {
  default     = "DNS"
  description = "DNS Validation Method"
  type        = "string"
}
