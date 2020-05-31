resource "aws_efs_file_system" "efsTest" {
  creation_token = "${var.token}"
  tags = {
    Name = "EFSTerraform"
  }
}
resource "aws_efs_mount_target" "efsMountTarget" {
  file_system_id  = "${aws_efs_file_system.efsTest.id}"
  subnet_id       = "${var.subnets}"
  security_groups = ["${aws_security_group.EFSSG.id}"]
}

resource "aws_security_group" "EFSSG" {
  name        = "EFSSG"
  description = "Sg group for EFS"
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
    Name = "Mahesh_efs_sg"
  }
}
terraform {
  backend "s3" {
    bucket                  = "bucketlifecycle"
    key                     = "terraform/us-east-1/efs.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "/home/ec2-user/aws-detail"
    profile                 = "DeshrajAdmin"
  }
}
output "efs_ID" {
  value = aws_efs_file_system.efsTest.id
}