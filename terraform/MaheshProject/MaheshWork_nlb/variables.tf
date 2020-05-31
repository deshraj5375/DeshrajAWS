variable "nlbname" {
  type    = "string"
  default = "NLBForInfra"
}
variable "internalLb" {
  type    = "string"
  default = "true"
}
variable "nlbType" {
  type    = "string"
  default = "network"
}
variable "subnets" {
  description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = ["subnet-0949a76f"]
}
variable "vpc" {
  type    = "string"
  default = "vpc-aba993d1"
}
variable "azName" {
  type    = "string"
  default = "us-east-1b"
}
variable "amiValue" {
  type    = "string"
  default = "ami-0323c3dd2da7fb37d"
}
variable "instanceType" {
  type    = "string"
  default = "t2.micro"
}
variable "keyName" {
  type    = "string"
  default = "awsJenkins"
}
variable "ebsSize" {
  type    = "string"
  default = "8"
}
#nlb health check
variable "nlbHelathCheck" {
  type    = "string"
  default = "true"
}
variable "nlbInterval" {
  type    = "string"
  default = "30"
}
variable "nlbPath" {
  type    = "string"
  default = "/"
}
variable "nlbPort" {
  type    = "string"
  default = "traffic-port"
}
variable "nlbProtocol" {
  type    = "string"
  default = "HTTP"
}
variable "timeoutPeriod" {
  type    = "string"
  default = "5"
}
variable "healthyCount" {
  type    = "string"
  default = "3"
}
variable "unhealthyCount" {
  type    = "string"
  default = "10"
}
variable "nlbResultCode" {
  type    = "string"
  default = "200"
}
#autoscaling
variable "asgMin" {
  type    = "string"
  default = "1"
}
variable "asgMax" {
  type    = "string"
  default = "1"
}
variable "asgDesiredcapacity" {
  type    = "string"
  default = "1"
}
variable "asgHelthCheckGracePeriod" {
  type    = "string"
  default = "500"
}
variable "asgHelathCheckType" {
  type    = "string"
  default = "ELB"
}
//variable "efsId" {
 // type    = "string"
  //default = "${data.terraform_remote_state.efs.efs_ID}"
//}