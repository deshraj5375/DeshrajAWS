variable "azName" {
    default = "us-east-1a"
}
variable "amiValue" { 
    default = "ami-0323c3dd2da7fb37d"
}
variable "instanceType" {  
    default = "t2.micro"
}
variable "keyName" {
    default = "awsJenkins"
}
variable "ebsSize" {
    default = "8"
}
variable "vpc" {
    default = "vpc-aba993d1"
}
variable "subnet" {
    default = "subnet-98866cc7"
}
variable "userData" {
    default = "userdata.sh"
}