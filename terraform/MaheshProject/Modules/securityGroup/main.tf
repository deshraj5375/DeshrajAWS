resource "aws_security_group" "sgtest" {
  name        = "sggroupTest"
  description = "Allow TLS inbound traffic"
  vpc_id = "${var.vpc}"
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
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
    Name = "TerraForm_POC"
  }
}

output "sgId"{
  value="${aws_security_group.sgtest.id}"
}