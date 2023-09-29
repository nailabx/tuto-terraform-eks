data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

#data "aws_eks_cluster" "cluster" {
#  depends_on = [module.eks]
#  name = module.eks.cluster_id
#}
#
#data "aws_eks_cluster_auth" "cluster" {
#  depends_on = [module.eks]
#  name = module.eks.cluster_id
#}
