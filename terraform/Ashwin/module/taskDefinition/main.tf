resource "aws_ecs_task_definition" "task-definition" {    
                                                        network_mode                = var.networkMode
                                                        family                      = var.family                                                        
                                                        execution_role_arn          = aws_iam_role.ecsExecutionRole.arn
                                                        requires_compatibilities    = var.requireCompatibility    
                                                        cpu                         = var.cpu
                                                        memory                      = var.memory  
                                                        container_definitions       = var.containerDefinition
                                                    }

resource "aws_iam_role" "ecsExecutionRole" {
  name = "ecsExecutionRole"
  assume_role_policy = <<-EOF
  {
  	"Version": "2012-10-17",
  	"Statement": [{
  		"Action": "sts:AssumeRole",
  		"Principal": {
  			"Service": "ecs-tasks.amazonaws.com"
  		},
  		"Effect": "Allow"
  	}]
  }
EOF
}

resource "aws_iam_role_policy" "ecsExecutionPolicy" {
  name = "ecsExecutionPolicy"
  role = aws_iam_role.ecsExecutionRole.id
  policy = <<-EOF
  {
  	"Version": "2012-10-17",
  	"Statement": [{
  		"Effect": "Allow",
  		"Action": [
  			"ecr:GetAuthorizationToken",
  			"ecr:BatchCheckLayerAvailability",
  			"ecr:GetDownloadUrlForLayer",
  			"ecr:BatchGetImage",
  			"logs:CreateLogStream",
  			"logs:PutLogEvents"
  		],
  		"Resource": "*"
  	}]
  }
EOF
}


output "taskarn" {
  value=aws_ecs_task_definition.task-definition.arn
}
 