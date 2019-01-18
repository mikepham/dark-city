resource "aws_alb" "lb" {
  name = "${local.domain_slug}"

  enable_deletion_protection = false
  security_groups            = ["${var.security_groups}"]
  subnets                    = "${var.subnets}"

  tags {
    Name = "${var.environment_domain}-alb"
  }
}

resource "aws_alb_listener" "http" {
  depends_on = ["aws_alb.lb"]

  load_balancer_arn = "${aws_alb.lb.arn}"
  port              = "${var.http_port}"
  protocol          = "${var.http_protocol}"

  default_action {
    type = "redirect"

    redirect {
      port        = "${var.ssl_port}"
      protocol    = "${var.ssl_protocol}"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  depends_on = [
    "aws_alb.lb",
    "aws_alb_target_group.target_group",
  ]

  certificate_arn   = "${var.certificate_arn}"
  load_balancer_arn = "${aws_alb.lb.arn}"
  port              = "${var.ssl_port}"
  protocol          = "${var.ssl_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    type             = "forward"
  }
}

