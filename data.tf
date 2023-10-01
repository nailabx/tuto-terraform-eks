#################################
#  EKS data
#################################

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

#################################
#  Other data
#################################
data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
