output "elasticsearch_security_group" {
  value = "${aws_security_group.elasticsearch.*.id}"
}
