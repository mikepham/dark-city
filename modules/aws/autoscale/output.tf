output "autoscaling_groups" {
  value = {
    arns  = ["${aws_autoscaling_group.autoscaling.*.arn}"]
    ids   = ["${aws_autoscaling_group.autoscaling.*.id}"]
    names = ["${aws_autoscaling_group.autoscaling.*.name}"]
  }
}

output "autoscaling_group_targets" {
  value = {
    arns  = ["${aws_alb_target_group.target_group.*.arn}"]
    ids   = ["${aws_alb_target_group.target_group.*.id}"]
    names = ["${aws_alb_target_group.target_group.*.name}"]
  }
}

output "autoscaling_security_groups" {
  value = [
    "${aws_security_group.etcd.id}",
    "${aws_security_group.member.id}",
  ]
}
