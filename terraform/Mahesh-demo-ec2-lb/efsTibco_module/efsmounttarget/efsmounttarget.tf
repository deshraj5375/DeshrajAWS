resource "aws_efs_mount_target" "efsMountTarget" {
  file_system_id  = "${var.efsid}"
  subnet_id       = "${var.subnets}"
  security_groups = ["${var.sgid}"]
}