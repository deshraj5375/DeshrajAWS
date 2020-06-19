module "EcsCluster" {
                            source           =  "./module/cluster"   
                            ecsClusterName   =   var.ecsClusterName
                    }

module "EcsClusterTaskDefinition" {
                            source                  =  "./module/taskDefinition"   
                            networkMode             = var.networkMode
                            family                  = var.family  
                            requireCompatibility    = var.requireCompatibility        
                            cpu                     = var.cpu    
                            memory                  = var.memory    
                            containerDefinition     = "${file("container.json")}"        
                    }

module "EcsClusterService" {
                            source                  =  "./module/service"   
                            name                    = var.name  
                            clusterId               = module.EcsCluster.clusterid
                            serviceLaunchType       = var.serviceLaunchType        
                            taskDenitionArn         = module.EcsClusterTaskDefinition.taskarn
                            taskDesiredCount        = var.taskDesiredCount          
                            DeploymentMaximumCount  = var.DeploymentMaximumCount          
                            deploymentHealthyPercent= var.deploymentHealthyPercent         
                            subnets                 = var.subnets         
                            sgGroupName             = var.sgGroupName         
                            vpc                     = var.vpc         
     
                    }