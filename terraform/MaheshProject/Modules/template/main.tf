module "ec2_poc" {
 source ="../ec2"

azName= "${var.azName}"
amiValue= "${var.amiValue}"
instanceType= "${var.instanceType}"
keyName= "${var.keyName}"
ebsSize= "${var.ebsSize}"
subnet= "${var.subnet}"
userData= "${file(var.userData)}"
sgGroup="${module.sg_poc.sgId}"
}

module "sg_poc"{
source = "../securityGroup" 
vpc= "${var.vpc}"
}