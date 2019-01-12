variable "agent_startup" {
  description = "Rancher Agent Command"
  type        = "string"
}

variable "agent_token" {
  description = "Rancher Agent Registration Token"
  type        = "string"
}

variable "ami_image" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "capacity" {
  type = "string"
}

variable "capacity_max" {
  type = "string"
}

variable "capacity_min" {
  type = "string"
}

variable "cluster_name" {
  type = "string"
}

variable "certificate_arn" {
  description = "Certificate ARN"
  type        = "string"
}

variable "cluster_size" {
  description = "Rancher Cluster Size"
  type        = "string"
}

variable "cluster_member_size" {
  description = "Rancher Cluster member Size"
  type        = "string"
}

variable "environment_domain" {
  description = "Environment Domain Name"
  type        = "string"
}

variable "environment_domain_tld" {
  description = "Environment Domain TLD"
  type        = "string"
}

variable "environment_name" {
  description = "Rancher Environment"
  type        = "string"
}

variable "environment_rancher_url" {
  description = "Rancher Environment Url"
  type        = "string"
}

variable "etcd_token" {
  description = "ETCD Cluster Token"
  type        = "string"
}

variable "http_port" {
  default     = 80
  description = "HTTP Port"
}

variable "http_protocol" {
  default     = "HTTP"
  description = "HTTP Protocol"
}

variable "iam_profile" {
  description = "AWS IAM Profile"
  type        = "string"
}

variable "instance_type" {
  type = "string"
}

variable "keypair" {
  description = "PEM Key Pair"
  type        = "string"
}

variable "ntp_hosts" {
  description = "NTP hosts"
  type        = "list"
}

variable "ssl_port" {
  default     = 443
  description = "SSL Port"
}

variable "ssl_protocol" {
  default     = "HTTPS"
  description = "SSL Protocol"
}

variable "subnets" {
  description = "Attached Subnets"
  type        = "list"
}

variable "monitoring" {
  description = "Enable Monitoring"
  type        = "string"
}

variable "security_groups" {
  description = "AWS Security Groups"
  type        = "list"
}

variable "termination_policies" {
  default = ["OldestInstance"]
  type    = "list"
}

variable "use_public_ip" {
  description = "Enable Public IP"
  type        = "string"
}

variable "volume_size" {
  description = "Volume Size"
  type        = "string"
}

variable "volume_type" {
  default     = "gp2"
  description = "Volume Type"
}

variable "vpc_ids" {
  description = "VPC Network IDs"
  type        = "list"
}
