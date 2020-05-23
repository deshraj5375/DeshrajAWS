variable "azName" {
    type = "string"
    default = "us-east-1a"
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