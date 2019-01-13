output "efs_arn" {
  description = "EFS ARN"
  depends_on  = ["${aws_efs_file_system.nfs}"]
  value       = "${aws_efs_file_system.nfs.arn}"
}

output "efs_dns_name" {
  description = "EFS DNS Name"
  depends_on  = ["${aws_efs_file_system.nfs}"]
  value       = "${aws_efs_file_system.nfs.dns_name}"
}

output "efs_id" {
  description = "EFS ID"
  depends_on  = ["${aws_efs_file_system.nfs}"]
  value       = "${aws_efs_file_system.nfs.id}"
}

output "efs_security_group" {
  value = "${aws_security_group.nfs.*.id}"
}
