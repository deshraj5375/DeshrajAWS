resource "aws_instance" "web" {  
  availability_zone =  "${var.azName}"
  vpc_security_group_ids =["${var.sgGroup}"]
  subnet_id ="${var.subnet}"  
  ami               = "${var.amiValue}"
  instance_type     = "${var.instanceType}"
  key_name          = "${var.keyName}"
  user_data = "${var.userData}"
  ebs_block_device {
  device_name = "/dev/xvda"
  volume_type = "gp2"
  volume_size = "${var.ebsSize}"
  delete_on_termination = "true"
  }
  tags = {
    Name = "Terraform_POC"
  }
}

output "public_ip" {
    value = "${aws_instance.web.public_ip}"
}