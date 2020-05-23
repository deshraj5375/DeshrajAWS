variable "albname" {
    type = "string"
    default = "ALBForInfra"
}
variable "albPublicFacing" {
    type = "string"
    default = "false"
}
variable "albType" {
    type = "string"
    default = "application"
}
variable "subnets" {
  description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = ["subnet-0949a76f","subnet-2d182513"]
}
variable "vpc" {
    type = "string"
    default = "vpc-aba993d1"
}
variable "azName" {
    type = "string"
    default = "us-east-1b"
}
variable "amiValue" {
    type = "string"
    default = "ami-0323c3dd2da7fb37d"
}
variable "instanceType" {
    type = "string"
    default = "t2.micro"
}
variable "keyName" {
    type = "string"
    default = "awsJenkins"
}
variable "ebsSize" {
    type = "string"
    default = "8"
}
#ALB health check
  variable "albHelathCheck" {
    type = "string"
    default = "true"
}
variable "albInterval" {
    type = "string"
    default = "30"
}
variable "albPath" {
    type = "string"
    default = "/"
}
variable "albPort" {
    type = "string"
    default = "traffic-port"
}
variable "albProtocol" {
    type = "string"
    default = "HTTP"
}
variable "timeoutPeriod" {
    type = "string"
    default = "5"
}
variable "healthyCount" {
    type = "string"
    default = "3"
}
variable "unhealthyCount" {
    type = "string"
    default = "3"
}
variable "albResultCode" {
    type = "string"
    default = "200"
}