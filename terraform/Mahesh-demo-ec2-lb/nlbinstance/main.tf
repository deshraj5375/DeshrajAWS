data "terraform_remote_state" "efs" {
    backend = "s3"
    config ={
        bucket  = "bucketlifecycle"
        key     = "terraform/us-east-1/efs1.tfstate"
        region  = "us-east-1"
        shared_credentials_file = "/home/ec2-user/aws-detail"
        profile                 = "DeshrajAdmin"
    }
}

module "nlbFirst" {
 source ="../nlbTibco/lb"   
   nlbname     = "${var.nlbname}"
   internalLb  = "${var.internalLb}"
   nlbType     = "${var.nlbType}"
   subnets     = "${var.subnets}"
 }

 module "nlbTargetGroup1" {
 source ="../nlbTibco/targetGroup" 
  tgName   = "${var.tgName}"
  vpc   = "${var.vpc}"
 }

 module "nlbListener1" {
 source ="../nlbTibco/listenrs"   
  lbArn = "${module.nlbFirst.lbARN}"
  tgArn = "${module.nlbTargetGroup1.tgARN}"
 }

 module "sggroup1" {
  source ="../nlbTibco/sggroup"   
  sgGroupName        = "${var.sgGroupName}"  
  vpc                = "${var.vpc}"
 }

data "template_file" "script" {
  template = "${file("userdata.tpl")}"
  vars = {
    efs_id = "${data.terraform_remote_state.efs.outputs.efs_ID}"
  }
}

module "launchTemplate" {
 source ="../nlbTibco/launchTemplate"  
 secuirtyGroupId     = "${module.sggroup1.sgID}"
 amiValue            = "${var.amiValue}"
 instanceType        = "${var.instanceType}"
 ebsSize             = "${var.ebsSize}"
 userdata            = "${data.template_file.script.rendered}"
 keyname             = "${var.keyname}"
}
module "AsgGroup" {
  source ="../nlbTibco/asg"
  asgName                   = "${var.asgName}"
  lcName                    = "${module.launchTemplate.launchName}"
  subnets                   = "${var.subnets}"
  asgMin                    = "${var.asgMin}"
  asgMax                    = "${var.asgMax}"
  asgDesiredcapacity        = "${var.asgDesiredcapacity}"
  asgHelthCheckGracePeriod  = "${var.asgHelthCheckGracePeriod}"
  asgHelathCheckType        = "${var.asgHelathCheckType}"
  tgArn                     = ["${module.nlbTargetGroup1.tgARN}"]
}

terraform {
  backend "s3" {
    bucket                  = "bucketlifecycle"
    key                     = "terraform/us-east-1/nlb1.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "/home/ec2-user/aws-detail"
    profile                 = "DeshrajAdmin"
  }
}
