variable "allow_unverified_ssl" {
  description = "Allow self-signed certificates"
  type        = "string"
}

variable "host" {
  description = "vSphere host"
  type        = "string"
}

variable "password" {
  description = "vSphere Credentials"
  type        = "string"
}

variable "username" {
  description = "vSphere Credentials"
  type        = "string"
}

variable "server" {
  description = "vShpere Server Address"
  type        = "string"
}
