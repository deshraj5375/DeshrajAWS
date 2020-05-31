data "terraform_remote_state" "efs" {
    backend = "s3"
    config ={
        bucket  = "bucketlifecycle"
        key     = "terraform/us-east-1/efs.tfstate"
        region  = "us-east-1"
        shared_credentials_file = "/home/ec2-user/aws-detail"
        profile                 = "DeshrajAdmin"
    }
}


#below is to create Network load balancer.
resource "aws_lb" "nlb" {
  provider                   = "aws.primary"
  name                       = "${var.nlbname}"
  internal                   = "${var.internalLb}"
  load_balancer_type         = "${var.nlbType}"
  subnets                    = "${var.subnets}"
  enable_deletion_protection = false
  tags = {
    Environment = "Mahesh_nlb"
  }
}
#Target group for nlb.
resource "aws_lb_target_group" "nlbtg" {
  provider = "aws.primary"
  name     = "nlb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc}"
  stickiness {
    enabled = false
    type    = "lb_cookie"
  }
}
#Targer group Listenrs.
resource "aws_lb_listener" "nlblistenr" {
  provider          = "aws.primary"
  load_balancer_arn = "${aws_lb.nlb.arn}"
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.nlbtg.arn}"
  }
}

#ASG creation.
resource "aws_launch_configuration" "asgLauncgConfig" {
  provider        = "aws.primary"
  security_groups = ["${aws_security_group.sgtest.id}"]
  image_id        = "${var.amiValue}"
  instance_type   = "${var.instanceType}"
  key_name        = "${var.keyName}"
  root_block_device {
    #device_name = "/dev/xvda"
    volume_type = "gp2"
    volume_size = "${var.ebsSize}"
  }
  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install httpd -y
                echo "This is created from Terraform" > /var/www/html/index.html                
                service httpd start
                yum install -y amazon-efs-utils
                mkdir efs
                mount -t efs "${data.terraform_remote_state.efs.outputs.efs_ID}":/ efs              
                EOF 
}
resource "aws_autoscaling_group" "asgGroup" {
  provider                  = "aws.primary"
  name                      = "Asg-nlb-example"
  launch_configuration      = "${aws_launch_configuration.asgLauncgConfig.name}"
  default_cooldown = 500  
vpc_zone_identifier       = "${var.subnets}"
  min_size                  = "${var.asgMin}"
  max_size                  = "${var.asgMax}"
  desired_capacity          = "${var.asgDesiredcapacity}"
  health_check_grace_period = "${var.asgHelthCheckGracePeriod}"
  health_check_type         = "${var.asgHelathCheckType}"
  target_group_arns         = ["${aws_lb_target_group.nlbtg.arn}"]
  tag {
    key                 = "Name"
    value               = "FromTerraform"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "sgtest" {
  provider    = "aws.primary"
  name        = "sggroupTest-nlb"
  description = "Allow inbound traffic"
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
terraform {
  backend "s3" {
    bucket                  = "bucketlifecycle"
    key                     = "terraform/us-east-1/nlb.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "/home/ec2-user/aws-detail"
    profile                 = "DeshrajAdmin"
  }
}

