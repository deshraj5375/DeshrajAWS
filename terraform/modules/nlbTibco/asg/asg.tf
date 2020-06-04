resource "aws_autoscaling_group" "asgGroup" {
   name                      = "${var.asgName}"
  launch_configuration      = "${var.lcName}"
  default_cooldown          = 500
  vpc_zone_identifier       = "${var.subnets}"
  min_size                  = "${var.asgMin}"
  max_size                  = "${var.asgMax}"
  desired_capacity          = "${var.asgDesiredcapacity}"
  health_check_grace_period = "${var.asgHelthCheckGracePeriod}"
  health_check_type         = "${var.asgHelathCheckType}"
  target_group_arns         = "${var.tgArn}"
  tag {
    key                 = "Name"
    value               = "FromTerraform"
    propagate_at_launch = true
  }
}