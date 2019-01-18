variable "algorithm" {
  default     = "RSA"
  description = "SSH KeyPair algorithm"
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

variable "keypair_name" {
  default     = ""
  description = "SSH KeyPair name"
  type        = "string"
}

variable "rsa_bits" {
  default     = 4096
  description = "Length of RSA KeyPair"
  type        = "string"
}
