output "efs_dns_name" {
  description = "EFS DNS Name"
  depends_on  = ["${aws_efs_file_system.member_storage}"]
  value       = "${aws_efs_file_system.member_storage.dns_name}"
}
