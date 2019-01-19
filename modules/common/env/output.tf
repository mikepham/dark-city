output "domain_name" {
  value = "${local.domain_name}"
}

output "domain_root" {
  value = "${local.domain_root}"
}

output "domain_slug" {
  value = "${local.domain_slug}"
}

output "env_domain_slug" {
  value = "${local.env_domain_slug}"
}

output "home" {
  value = "${data.external.env.result["home"]}"
}

output "username" {
  value = "${data.external.env.result["username"]}"
}
