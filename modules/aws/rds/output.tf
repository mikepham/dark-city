output "arn" {
  value = "${aws_db_instance.database.arn}"
}

output "ca_cert_identifier" {
  value = "${aws_db_instance.database.ca_cert_identifier}"
}

output "endpoint" {
  value = "${replace(aws_db_instance.database.endpoint, ":${aws_db_instance.database.port}", "")}"
}

output "hosted_zone_id" {
  value = "${aws_db_instance.database.hosted_zone_id}"
}

output "id" {
  value = "${aws_db_instance.database.id}"
}

output "name" {
  value = "${aws_db_instance.database.name}"
}

output "port" {
  value = "${aws_db_instance.database.port}"
}

output "resouce_id" {
  value = "${aws_db_instance.database.resource_id}"
}

output "username" {
  value = "${aws_db_instance.database.username}"
}
