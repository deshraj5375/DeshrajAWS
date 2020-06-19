resource "aws_ecs_cluster" "ecsCluster" {
  name = var.ecsClusterName
}

output "clusterid" {
  value=aws_ecs_cluster.ecsCluster.id
}
output "clusterarn" {
  value=aws_ecs_cluster.ecsCluster.arn
}