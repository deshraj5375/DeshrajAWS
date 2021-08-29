resource "aws_instance" "web" {  
  availability_zone =  "${var.azName}"
  vpc_security_group_ids =["${aws_security_group.sgtest.id}"]
  subnet_id ="${var.subnet}"
  //security_groups   = ["${aws_security_group.sgtest.id}"]
  ami               = "${var.amiValue}"
  instance_type     = "${var.instanceType}"
  key_name          = "${var.keyName}"
  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                useradd tibcouser -u 32978 -m -s /bin/bash -c "tibco local user"
                echo "tibcouser:tibcouser" |chpasswd
                echo "root:password"|chpasswd
                sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
                service sshd restart                
                yum install httpd -y
                echo "This is created from Terraform" > /var/www/html/index.html                
                service httpd start
                EOF 
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
    Name = "allow_tls"
  }
}
output "public_ip" {
    value = "${aws_instance.web.public_ip}"
}