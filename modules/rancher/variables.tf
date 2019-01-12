variable "access_key" {
  description = "Rancher Access Key"
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

variable "drone_admin_accounts" {
  description = "Drone Admin Accounts"
  type        = "list"
}

variable "drone_database_disk_size" {
  description = "Drone Database Disk Size"
  type        = "string"
}

variable "drone_database_instance_type" {
  description = "Drone Database Instance Type"
  type        = "string"
}

variable "drone_database_name" {
  description = "Drone Database Name"
  type        = "string"
}

variable "drone_database_parameter_group" {
  description = "Drone Database Parameter Group"
  type        = "string"
}

variable "drone_database_password" {
  description = "Drone Database Password"
  type        = "string"
}

variable "drone_database_type" {
  description = "Drone Database Type"
  type        = "string"
}

variable "drone_database_type_version" {
  description = "Drone Database Type Version"
  type        = "string"
}

variable "drone_database_username" {
  description = "Drone Database UserName"
  type        = "string"
}

variable "drone_image_tag" {
  description = "Drone Image Tag"
  type        = "string"
}

variable "drone_github_client" {
  description = "Drone GitHub Client"
  type        = "string"
}

variable "drone_github_organizations" {
  description = "Drone GitHub Organizations"
  type        = "list"
}

variable "drone_github_secret" {
  description = "Drone GitHub Secret"
  type        = "string"
}

variable "drone_shared_secret" {
  description = "Drone Shared Secret"
  type        = "string"
}

variable "drone_enabled" {
  description = "Enable Drone Module"
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

variable "secret_key" {
  description = "Rancher Secret Key"
  type        = "string"
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
