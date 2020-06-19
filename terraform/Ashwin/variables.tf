variable "ecsClusterName" {
	default = "ECS-Fargate-POC"
}
variable "networkMode" {
	default = "awsvpc"
}
variable "family" {
	default = "ecs-poc"
}
variable "requireCompatibility" {
	default = ["FARGATE"] 
}
variable "cpu" {
	default = "256"
}
variable "memory" {
	default = "512"
}
variable "name" {
	default = "service-poc"
}
variable "serviceLaunchType" {
	default = "FARGATE"
}
variable "taskDesiredCount" {
	default = "1"
}  
variable "DeploymentMaximumCount" {
	default = "200"
}
variable "deploymentHealthyPercent" {
	default = "0"
}
variable "subnets" {
	default = ["subnet-98866cc7"]
} 
variable "sgGroupName" {
	default = "sgGroupForECSService"
}
variable "vpc" {
	default = "vpc-aba993d1"
}
