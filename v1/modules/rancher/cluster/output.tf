output "cluster_target_groups" {
  value = [{
    arn  = "${aws_alb_target_group.target_group.*.arn}"
    id   = "${aws_alb_target_group.target_group.*.id}"
    name = "${aws_alb_target_group.target_group.*.name}"
  }]
}
