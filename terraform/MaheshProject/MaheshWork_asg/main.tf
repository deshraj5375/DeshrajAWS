#below is to create application load balancer.
resource "aws_lb" "alb" {
  provider         = "aws.primary"  
  name               = "${var.albname}"
  internal           = "${var.internalLb}"
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
  provider         = "aws.primary"  
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
  provider         = "aws.primary"  
  name     = "Alb-tg"
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
  provider         = "aws.primary"  
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.albtg.arn}"
  } 
}

#ASG creation.
resource "aws_launch_configuration" "asgLauncgConfig" {  
  provider         = "aws.primary"  
  security_groups   = ["${aws_security_group.sgtest.id}"]
  image_id          = "${var.amiValue}"
  instance_type     = "${var.instanceType}"
  key_name          = "${var.keyName}"
  root_block_device {
  #device_name = "/dev/xvda"
  volume_type = "gp2"
  volume_size = "${var.ebsSize}"  
  }
  user_data= <<-EOF
                #!/bin/bash
                yum update -y
                yum install httpd -y
                echo "This is created from Terraform" > /var/www/html/index.html                
                service httpd start
                yum install -y amazon-efs-utils                
                EOF 
}
resource "aws_autoscaling_group" "asgGroup" {
  provider         = "aws.primary"  
  name                      = "Asg-example"
  launch_configuration      = "${aws_launch_configuration.asgLauncgConfig.name}"
  vpc_zone_identifier       = "${var.subnets}"
  min_size                  = "${var.asgMin}"
  max_size                  = "${var.asgMax}"
  desired_capacity          = "${var.asgDesiredcapacity}"
  health_check_grace_period = "${var.asgHelthCheckGracePeriod}"
  health_check_type         = "${var.asgHelathCheckType}"
  target_group_arns         = ["${aws_lb_target_group.albtg.arn}"]
  tag {
    key = "Name"
    value="FromTerraform"
    propagate_at_launch=true
  }
}

resource "aws_security_group" "sgtest" {
  provider         = "aws.primary"  
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
    security_groups =["${aws_security_group.lbsg.id}"]
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
terraform {
  backend "s3" {
    bucket                  = "bucketlifecycle"
    key                     = "terraform/us-east-1/asgPrimary.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "/home/ec2-user/aws-detail"
    profile                 = "DeshrajAdmin"
  }
}