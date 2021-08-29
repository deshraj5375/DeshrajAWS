resource "aws_lb" "nlb" {
  name                       = "${var.nlbname}"
  internal                   = "${var.internalLb}"
  load_balancer_type         = "${var.nlbType}"
  subnets                    = "${var.subnets}"
  tags = {
    Environment = "NLBTesting"
  }
}
output "lbARN" {
value="${aws_lb.nlb.arn}"
}