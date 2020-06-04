variable "nlbname" {
	default = "QOSEMSNLB"
}
variable "internalLb" {
	default = "true"
}
variable "nlbType" {
	default = "network"
}
variable "subnets" {
	default     = ["subnet-98866cc7"]
}
variable "tgName" {
	default     = "nlbTG"
}
variable "vpc" {
	default     = "vpc-aba993d1"
}
variable "sgGroupName" {
	default     = "nlbEC2SGGroup"
}
variable "amiValue" {
	default     = "ami-09d95fab7fff3776c"
}
variable "azName" {
  default = "us-east-1a"
}
variable "instanceType" {
	default     = "t2.micro"
}
variable "ebsSize" {
	default     = "8"
}

variable "keyname" {
	default     = "awsJenkins"
}
variable "asgName" {
	default     = "TibcoAsgname1"
}
variable "asgMin" {
	default     = "1"
}
 variable "asgMax" {
	default     = "1"
}
variable "asgDesiredcapacity" {
	default     = "1"
}
variable "asgHelthCheckGracePeriod" {
	default     = "300"
}
variable "asgHelathCheckType" {
	default     = "ELB"
}