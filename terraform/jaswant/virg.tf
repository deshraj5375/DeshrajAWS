provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "/home/ec2-user/aws-detail"
  profile                 = "DeshrajAdmin"
  alias                   = "peer"
 }

resource "aws_vpc" "vpcohio" {
  provider         = "aws.peer"  
  cidr_block       = "10.2.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpcohio"
  }
}
resource "aws_subnet" "vpcohiosubnet" {
  provider         = "aws.peer"
  vpc_id     = "${aws_vpc.vpcohio.id}"
  cidr_block = "10.2.0.0/24"
  tags = {
    Name = "vpcohiosubnet"
  }
}
resource "aws_internet_gateway" "vpcohiogw" {
  provider         = "aws.peer"    
  vpc_id = "${aws_vpc.vpcohio.id}"

  tags = {
    Name = "vpcohiogw"
  }
}

resource "aws_route_table" "vpcohioroute" {
  provider = "aws.peer"    
  vpc_id = "${aws_vpc.vpcohio.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpcohiogw.id}"
  }
  tags = {
    Name = "vpcohioroute"
  }
}

resource "aws_ec2_transit_gateway" "tgw-ohio" {
  description = "this is to create transit gateway"
  provider    = "aws.peer" 
  auto_accept_shared_attachments = "enable"
  }

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-ohio-attachment-vpc" {
  provider         = "aws.peer" 
  subnet_ids         = ["${aws_subnet.vpcohiosubnet.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-ohio.id}"
  vpc_id             = "${aws_vpc.vpcohio.id}"
   tags = {
    Name = "Peer-TGW-vpc"
  }
}

resource "aws_ec2_transit_gateway_route" "tgw-route-peering-ohio" {
 provider         = "aws.peer" 
   destination_cidr_block= "10.1.0.0/24"
   transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-ohio-attachment-vpc.id}"
   transit_gateway_route_table_id = "${aws_ec2_transit_gateway.tgw-ohio.association_default_route_table_id}"
}


provider "aws" {
  alias  = "local"  
  region                  = "us-east-1"
  shared_credentials_file = "/home/ec2-user/aws-detail"
  profile                 = "DeshrajAdmin"
}
resource "aws_vpc" "vpc1" {
   provider = "aws.local"     
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpc1"
  }
}
resource "aws_subnet" "vpc1subnet" {
   provider = "aws.local"         
  vpc_id     = "${aws_vpc.vpc1.id}"
  cidr_block = "10.1.0.0/24"
  tags = {
    Name = "vpc1subnet"
  }
}
resource "aws_internet_gateway" "Vpc1gw" {
   provider = "aws.local"           
  vpc_id = "${aws_vpc.vpc1.id}"

  tags = {
    Name = "Vpc1gw"
  }
}

resource "aws_route_table" "vpc1route" {
   provider = "aws.local"        
  vpc_id = "${aws_vpc.vpc1.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.Vpc1gw.id}"
  }

  tags = {
    Name = "vpc1route"
  }
}

resource "aws_ec2_transit_gateway" "tgw-vir" {
   provider = "aws.local"         
  description = "this is to create transit gateway"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-vir-attachment-vpc" {
   provider = "aws.local"          
  subnet_ids         = ["${aws_subnet.vpc1subnet.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vir.id}"
  vpc_id             = "${aws_vpc.vpc1.id}"
   tags = {
    Name = "Peer-TGW-vpc"
  }
}


resource "aws_ec2_transit_gateway_peering_attachment" "tgw-vir-attachment-peering" {
   provider = "aws.local"        
  peer_account_id         = "108989018919"
  peer_region             = "us-east-2"
  peer_transit_gateway_id = "${aws_ec2_transit_gateway.tgw-ohio.id}"
  transit_gateway_id      = "${aws_ec2_transit_gateway.tgw-vir.id}"

  tags = {
    Name = "peer"
  }
}

resource "aws_ec2_transit_gateway_route" "tgw-route-peering" {
   provider = "aws.local"
   destination_cidr_block= "10.2.0.0/24"
   transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-vir-attachment-vpc.id}"
   transit_gateway_route_table_id = "${aws_ec2_transit_gateway.tgw-vir.association_default_route_table_id}"
}

