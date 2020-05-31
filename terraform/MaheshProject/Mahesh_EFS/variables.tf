variable "token" {
  type    = "string"
  default = "EFSTest"
}
variable "subnets" {
  description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  default     = "subnet-0949a76f"
}