output "rancher_environment_id" {
  depends_on  = ["rancher_environment.env"]
  description = "Rancher Environment ID"
  value       = "${rancher_environment.env.id}"
}

output "rancher_security_groups" {
  depends_on = [
    "cluster",
    "elasticsearch",
    "security",
  ]

  value = [
    "${module.security.security_groups}",
    "${module.nfs.efs_security_group}",
    "${module.elasticsearch.elasticsearch_security_group}",
  ]
}

output "rancher_efs_security_groups" {
  depends_on = [
    "cluster",
  ]

  value = ["${module.nfs.efs_security_group}"]
}

output "rancher_es_security_groups" {
  depends_on = [
    "cluster",
  ]

  value = ["${module.elasticsearch.elasticsearch_security_group}"]
}

output "rancher_member_security_groups" {
  depends_on = [
    "cluster",
  ]

  value = ["${module.security.security_groups}"]
}
