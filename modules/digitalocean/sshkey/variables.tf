variable "name" {
  description = "Name of SSH key"
  type        = "string"
}

variable "public_key" {
  default     = ""
  description = "Public key"
  type        = "string"
}
