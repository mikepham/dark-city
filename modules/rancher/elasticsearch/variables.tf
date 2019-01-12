variable "domain" {
  description = "Domain"
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

variable "elasticsearch_version" {
  description = "ElasticSearch Version"
  type        = "string"
}
