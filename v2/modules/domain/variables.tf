variable "domain" {
  description = "Zone record for domain"
  type        = "string"
}

variable "environment" {
  default     = ""
  description = "Environment name"
  type        = "string"
}
