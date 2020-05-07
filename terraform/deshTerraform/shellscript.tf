resource "null_resource" "web" {
    provisioner "local-exec" {
    command = "bash /home/ec2-user/deshTerraform/script.sh deshraj"
  }
}
