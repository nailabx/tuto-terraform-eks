module "secrets-access" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name                                          = "secrets-access"
  attach_external_secrets_policy                     = true
#  external_secrets_ssm_parameter_arns                = ["arn:aws:ssm:*:*:parameter/foo"]
#  external_secrets_secrets_manager_arns              = ["arn:aws:secretsmanager:*:*:secret:bar"]
  external_secrets_secrets_manager_arns              = ["arn:aws:secretsmanager:*:*:secret:*"]
#  external_secrets_kms_key_arns                      = ["arn:aws:kms:*:*:key/1234abcd-12ab-34cd-56ef-1234567890ab"]
  external_secrets_secrets_manager_create_permission = false

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["default:secrets-access"]
    }
  }
  tags = {
    Name = "secrets-access"
  }
}

resource "kubernetes_service_account" "secrets-access" {
  metadata {
    name = "secrets-access"
    namespace = "default"
    annotations = {
      "iam.amazonaws.com/role": module.secrets-access.iam_role_arn
    }
  }
}