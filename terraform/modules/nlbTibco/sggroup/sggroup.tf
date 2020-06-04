resource "aws_security_group" "sgtest" {
  name        = "${var.sgGroupName}"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpc}"
  ingress {
    description = "port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Port80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SGGroupTibco"
  }
}
output "sgID" {
value="${aws_security_group.sgtest.id}"
}

