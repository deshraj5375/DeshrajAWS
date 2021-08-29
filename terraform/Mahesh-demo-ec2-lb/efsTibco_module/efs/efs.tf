resource "aws_efs_file_system" "efsTest" {
  creation_token = "${var.token}"
  tags = {
    Name = "EFSTibco"
  }
}
output "efs_ID" {
  value = aws_efs_file_system.efsTest.id
}