#below is to create application load balancer.
resource "aws_lb" "alb" {
  name               = "${var.albname}"
  internal           = "${var.albPublicFacing}"
  load_balancer_type = "${var.albType}"
  security_groups    = ["${aws_security_group.lbsg.id}"]  
  subnets            = "${var.subnets}"
  enable_deletion_protection = false
  tags = {
    Environment = "Mahesh_alb"
  }
}
# SG group for ALB
resource "aws_security_group" "lbsg" {
  name        = "ALBSG"
  description = "Sg group for Application LB"
  ingress {
    description = "Port 80 allowed"
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
    Name = "Mahesh_alb_sg"
  }
}

#Target group for ALB.
resource "aws_lb_target_group" "albtg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP" 
  vpc_id   = "${var.vpc}"
  health_check{
  enabled="${var.albHelathCheck}"
  interval="${var.albInterval}"
  path="${var.albPath}"
  port="${var.albPort}"
  protocol="${var.albProtocol}"
  timeout="${var.timeoutPeriod}"
  healthy_threshold ="${var.healthyCount}"
  unhealthy_threshold="${var.unhealthyCount}"
  matcher="${var.albResultCode}"

  }
}
#Targer group Listenrs.
resource "aws_lb_listener" "alblistenr" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.albtg.arn}"
  } 
}

#Target Group Attachements.
resource "aws_lb_target_group_attachment" "albtgattchment" {
  target_group_arn = "${aws_lb_target_group.albtg.arn}"
  target_id        = "${aws_instance.web.id}"
  port             = 80
  
}
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
  user_data= <<-EOF
                #!/bin/bash
                yum update -y
                yum install httpd -y
                echo "This is created from Terraform" > /var/www/html/index.html                
                service httpd start
                EOF
  tags = {
    Name = "FromTerraform"
  }
}
resource "aws_security_group" "sgtest" {
  name        = "sggroupTest"
  description = "Allow TLS inbound traffic"
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
    Name = "allow_tls"
  }
}