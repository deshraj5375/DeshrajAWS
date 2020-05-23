resource "aws_instance" "web" {  
  availability_zone =  "${var.azName}"
  security_groups   = ["${aws_security_group.sgtest.name}"]
  ami               = "${var.amiValue}"
  instance_type     = "${var.instanceType}"
  key_name          = "${var.keyName}"
  ebs_block_device {
  device_name = "/dev/xvda"
  volume_type = "gp2"
  volume_size = "${var.ebsSize}"
  delete_on_termination = "true"
  }
  tags = {
    Name = "FromTerraform"
  }
}
resource "aws_security_group" "sgtest" {
  name        = "sggroupTest"
  description = "Allow TLS inbound traffic"
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}