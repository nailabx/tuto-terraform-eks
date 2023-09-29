locals {
  name = var.cluster_name
  tags = {
    GithubRepo = "fineract-terraform-eks"
    GithubOrg  = "fineract-terraform-eks"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  # IPV6
  cluster_ip_family = "ipv4"

  create_cni_ipv6_iam_policy = true

  # External encryption key
  create_kms_key = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms.key_arn
  }

  iam_role_additional_policies = {
    additional = aws_iam_policy.additional.arn
  }

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true
  enable_irsa = true
  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/gitlab"
      username = "gitlab"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/readonly"
      username = "readonly:{{SessionName}}"
      groups   = ["view"]
    },
    
  ]

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets


#  eks_managed_node_group_defaults = {
#    ami_type       = "AL2_x86_64"
##    instance_types = ["t3.small", "t3.medium"]
#    iam_role_attach_cni_policy = true
#  }

  eks_managed_node_groups = {
    ops = {
      name           = "${var.cluster_name}-ops"
      iam_role_name  =  "${var.cluster_name}-instance-profile"
      min_size       = 1
      max_size       = var.instance_count
      desired_size   = var.instance_count
      instance_types = [var.instance_type]


      create_iam_role          = true
      iam_role_use_name_prefix = false
      iam_role_description     = "EKS managed node group complete example role"
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
      }
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        additional                         = aws_iam_policy.additional.arn
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

    }
  }

}


resource "aws_iam_policy" "additional" {
  name = "${local.name}-additional"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "~> 1.5"

  aliases               = ["eks/${local.name}"]
  description           = "${local.name} cluster encryption key"
  enable_default_policy = true
  key_owners            = [data.aws_caller_identity.current.arn]

  tags = local.tags
}

module "lb_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "${var.cluster_name}_eks_lb"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}




