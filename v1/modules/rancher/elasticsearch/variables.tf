variable "account_id" {
  description = "AWS Account ID"
  type        = "string"
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = "list"
}

variable "dedicated_master_count" {
  description = "Dedicated Master Count"
  type        = "string"
}

variable "dedicated_master_enabled" {
  description = "Enable Dedicated Master"
  type        = "string"
}

variable "dedicated_master_type" {
  description = "Dedicated Master Instance Type"
  type        = "string"
}

variable "domain" {
  description = "Domain"
  type        = "string"
}

variable "enabled" {
  description = "Enable Module"
  type        = "string"
}

variable "encrypt_at_rest" {
  description = "Encrypt Data at Rest"
  type        = "string"
}

variable "environment" {
  description = "Environment"
  type        = "string"
}

variable "elasticsearch_version" {
  description = "ElasticSearch Version"
  type        = "string"
}

variable "node2node_encryption" {
  description = "Enable Node-to-Node Encryption"
  type        = "string"
}

variable "instance_count" {
  description = "Count of ElasticSearch Nodes"
  type        = "string"
}

variable "instance_type" {
  description = "AWS Instance Type"
  type        = "string"
}

variable "snapshot_start_hour" {
  description = "When to start snapshots"
  type        = "string"
}

variable "subnets" {
  description = "AWS Subnets"
  type        = "list"
}

variable "volume_size" {
  description = "Volume Size"
  type        = "string"
}

variable "volume_type" {
  description = "Volume Type"
  type        = "string"
}

variable "vpc_ids" {
  description = "VPCs"
  type        = "list"
}

variable "zone_awareness_enabled" {
  description = "Enable Zone Awareness"
  type        = "string"
}
