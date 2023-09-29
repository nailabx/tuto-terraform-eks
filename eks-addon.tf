module "eks_blueprints_kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"
  eks_cluster_id                    = module.eks.cluster_name

  enable_external_dns                  = true
  eks_cluster_domain                   = var.nailabx_domain

  external_dns_route53_zone_arns = [
    "arn:aws:route53:::hostedzone/*"
  ]

}
