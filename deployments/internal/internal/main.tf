module "domain" "dns" {
  source = "../../../modules/vmware/domain"

  domain      = "in.nativecode.com"
  environment = "prod"
  ttl         = "1m0s"
  type        = "A"
  value       = "192.168.1.40"
}
