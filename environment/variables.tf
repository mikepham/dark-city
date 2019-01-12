variable "rancher_ami_image" {
  description = "Rancher AMI Image ID"
  type        = "string"
}

variable "rancher_availability_zones" {
  description = "AWS Availibility Zones"
  type        = "list"
}

variable "rancher_capacity" {
  default     = 3
  description = "AutoScaling Capacity"
}

variable "rancher_capacity_max" {
  default     = 5
  description = "AutoScaling Capacity Max"
}

variable "rancher_capacity_min" {
  default     = 3
  description = "AutoScaling Capacity Min"
}

variable "rancher_certificate_domain" {
  description = "Rancher Certificate Domain"
  type        = "string"
}

variable "rancher_cluster_size" {
  default     = 1
  description = "Instance Count"
}

variable "rancher_cluster_member_size" {
  default     = 3
  description = "Cluster member Size"
}

variable "rancher_environment_domain" {
  description = "Rancher Environment Domain"
  type        = "string"
}

variable "rancher_environment" {
  description = "Environment Name"
  type        = "string"
}

variable "rancher_etcd_token" {
  default     = "etcd-token"
  description = "Rancher ETCD Cluster Token"
}

variable "rancher_iam_profile" {
  default     = "EC2"
  description = "AWS IAM Profile"
}

variable "rancher_instance_type" {
  description = "AWS Instance Type"
  type        = "string"
}

variable "rancher_keypair" {
  description = "Rancher AWS PEM Key Pair"
  type        = "string"
}

variable "rancher_monitoring" {
  default     = true
  description = "Rancher Enable AWS Monitoring"
}

variable "rancher_ntp_hosts" {
  default     = ["time.nist.gov"]
  description = "NTP Hosts"
  type        = "list"
}

variable "rancher_subnets" {
  description = "Rancher AWS Subnets"
  type        = "list"
}

variable "rancher_url" {
  description = "Rancher URL"
  type        = "string"
}

variable "rancher_use_public_ip" {
  default     = true
  description = "Rancher Enable Public IP"
}

variable "rancher_volume_size" {
  default     = 8
  description = "Rancher Volume Size"
}

variable "rancher_vpc_ids" {
  description = "Rancher VPC Networks"
  type        = "list"
}
