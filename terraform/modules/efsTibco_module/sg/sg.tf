resource "aws_security_group" "EFSSG" {
  name        = "${var.sgName}"
  description = "Sg group for EFS"
  vpc_id="${var.vpcid}"
  ingress {
    description = "Port 2049 allowed"
    from_port   = 2049
    to_port     = 2049
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
    Name = "TIBCO_EFS_SG"
  }
}

output "sg_ID" {
  value = aws_security_group.EFSSG.id
}
