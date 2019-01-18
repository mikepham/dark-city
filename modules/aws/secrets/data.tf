data "aws_secretsmanager_secret" "secret_key" {
  name = "${var.secret_name}"
}

data "aws_secretsmanager_secret_version" "secrets_json" {
  secret_id = "${data.aws_secretsmanager_secret.secret_key.id}"
}

data "jsondecode_decode" "secrets" {
  input = "${data.aws_secretsmanager_secret_version.secrets_json.secret_string}"
}
