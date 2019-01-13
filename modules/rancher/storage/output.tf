output "efs_dns_name" {
  description = "EFS DNS Name"
  depends_on  = ["${aws_efs_file_system.member_storage}"]
  value       = "${aws_efs_file_system.member_storage.dns_name}"
}

output "efs_security_group" {
  value = "${aws_security_group.member_storage.*.id}"
}
