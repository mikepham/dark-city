resource "aws_alb" "lb" {
  name = "${var.domain_slug}"

  enable_deletion_protection = false
  security_groups            = ["${var.security_groups}"]
  subnets                    = ["${var.subnets}"]

  tags {
    Name = "${var.domain_slug}-alb"
  }
}

resource "aws_alb_listener" "http" {
  depends_on = ["aws_alb.lb"]

  load_balancer_arn = "${aws_alb.lb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"

  default_action {
    type = "redirect"

    redirect {
      port        = "${var.listener_secure_port}"
      protocol    = "${var.listener_secure_protocol}"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  depends_on = ["aws_alb.lb"]

  certificate_arn   = "${var.certificate_arn}"
  load_balancer_arn = "${aws_alb.lb.arn}"
  port              = "${var.listener_secure_port}"
  protocol          = "${var.listener_secure_protocol}"

  default_action {
    target_group_arn = "${var.target_group_arns}"
    type             = "forward"
  }
}
