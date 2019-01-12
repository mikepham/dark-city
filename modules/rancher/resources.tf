resource "rancher_environment" "env" {
  name = "${var.environment_name}"

  description   = "Identity Provider"
  orchestration = "cattle"
}

resource "rancher_registration_token" "member" {
  name = "member_token"

  description    = "Rancher registration token"
  environment_id = "${rancher_environment.env.id}"
}
