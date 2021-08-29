module "EFS" {
 source ="../efsTibco_module/efs"   
  token = "${var.token}"
}
module "SGGroup" {
 source ="../efsTibco_module/sg"   
  sgName="${var.sgName}"
  vpcid="${var.vpcid}"
}
module "mountTarget" {
 source ="../efsTibco_module/efsmounttarget"   
  efsid         = "${module.EFS.efs_ID}"
  subnets       = "${var.subnets}"
  sgid          = "${module.SGGroup.sg_ID}"
  }
  
terraform {
  backend "s3" {
    bucket                  = "bucketlifecycle"
    key                     = "terraform/us-east-1/efs1.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "/home/ec2-user/aws-detail"
    profile                 = "DeshrajAdmin"
  }
}
output "efs_ID"{
  value="${module.EFS.efs_ID}"
}
