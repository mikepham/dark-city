output "security_groups" {
  value = [
    "${aws_security_group.member.id}",
    "${aws_security_group.member_database.id}",
    "${aws_security_group.member_etcd.id}",
    "${aws_security_group.member_storage.id}",
  ]
}

output "security_group" {
  value = "${aws_security_group.member.id}"
}

output "security_group_database" {
  value = "${aws_security_group.member_database.id}"
}

output "security_group_etcd" {
  value = "${aws_security_group.member_etcd.id}"
}

output "security_group_storage" {
  value = "${aws_security_group.member_storage.id}"
}
