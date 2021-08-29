resource "aws_launch_configuration" "asgLauncgConfig" {
  security_groups = ["${var.secuirtyGroupId}"]
  image_id        = "${var.amiValue}"
  instance_type   = "${var.instanceType}"
  key_name        = "${var.keyname}"
  root_block_device {
    #device_name = "/dev/xvda"
    volume_type = "gp2"
    volume_size = "${var.ebsSize}"
  }
  user_data = "${var.userdata}"
}

output "launchName" {
value="${aws_launch_configuration.asgLauncgConfig.name}"
}
