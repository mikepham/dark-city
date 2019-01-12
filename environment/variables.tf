variable "drone_admin_accounts" {
  description = "Drone Admin Account"
  type        = "list"
}

variable "drone_database_disk_size" {
  default     = 10
  description = "Drone Database Disk Size"
}

variable "drone_database_instance_type" {
  description = "Drone Database Instance Type"
  type        = "string"
}

variable "drone_database_name" {
  default     = "drone"
  description = "Drone Database Name"
}

variable "drone_database_type" {
  default     = "mysql"
  description = "Database Type"
}

variable "drone_database_type_version" {
  default     = "5.7"
  description = "Drone Database Type Version"
}

variable "drone_database_parameter_group" {
  default     = "default.mysql5.7"
  description = "Drone Database Parameter Group"
}

variable "drone_database_username" {
  default     = "drone"
  description = "Drone Database UserName"
}

variable "drone_enabled" {
  description = "Enables Drone Deployment"
  type        = "string"
}

variable "drone_github_organizations" {
  description = "Drone GitHub Organizations"
  type        = "list"
}

variable "drone_image_tag" {
  default     = "0.8-alpine"
  description = "Drone Image Docker Tag"
}

variable "elasticsearch_dedicated_master_count" {
  description = "Number of Dedicated Master Nodes"
  type        = "string"
}

variable "elasticsearch_dedicated_master_enabled" {
  description = "Enable Dedicated Master Node"
  type        = "string"
}

variable "elasticsearch_dedicated_master_type" {
  description = "Master Node Instance Type"
  type        = "string"
}

variable "elasticsearch_instance_count" {
  description = "Number of ElasticSearch Instances"
  type        = "string"
}

variable "elasticsearch_instance_type" {
  description = "ElasticSearch Instance Type"
  type        = "string"
}

variable "elasticsearch_node2node_encryption" {
  description = "Enable Node-to-Node Encryption"
  type        = "string"
}

variable "elasticsearch_snapshot_start_hour" {
  description = "When to start the snapshot"
  type        = "string"
}

variable "elasticsearch_version" {
  description = "ElasticSearch Version"
  type        = "string"
}

variable "elasticsearch_zone_awareness_enabled" {
  description = "Enable AWS Zone Awareness"
  type        = "string"
}

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
