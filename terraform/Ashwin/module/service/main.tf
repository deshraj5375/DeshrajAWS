resource "aws_ecs_service" "fargate_service" {
    name                                        = var.name
    cluster                                     = var.clusterId
    launch_type                                 = var.serviceLaunchType
    task_definition                             = var.taskDenitionArn  
    desired_count                               = var.taskDesiredCount  
    deployment_maximum_percent                  = var.DeploymentMaximumCount
    deployment_minimum_healthy_percent          = var.deploymentHealthyPercent 
    network_configuration {
                                assign_public_ip = true
                                security_groups  = [aws_security_group.sgtest.id]
                                subnets          = var.subnets
                          }
    
}

resource "aws_security_group" "sgtest" {
  name        = "${var.sgGroupName}"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpc}"
  ingress {
    description = "port 22"
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
}