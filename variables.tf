variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "cluster_name" {
  default     = "irsa-terraform-eks"
  description = "EKS Cluster name"
}

variable "cluster_version" {
  default     = "1.28"
  description = "Kubernetes version"
}

variable "instance_type" {
  default     = ["t3.small", "t3.medium"]
  type = list(string)
  description = "EKS node instance type"
}

variable "instance_count" {
  default     = 3
  description = "EKS node count"
}

variable "agent_namespace" {
  default     = "gitlab-agent"
  description = "Kubernetes namespace to install the Agent"
}

variable "agent_token" {
  description = "Agent token (provided after registering an Agent in GitLab)"
  default ="7FUH1XYPUH_PsBNE91ZgaGmqqCQsW5zvx_bpUCD7wNyu2c7u4w"
  sensitive   = true
}

variable "kas_address" {
  description = "Agent Server address (provided after registering an Agent in GitLab)"
  default = "wss://kas.gitlab.com"
}


variable "nailabx_domain" {
  default = "nailabx.com"
}

variable "readonly_role_name" {
  default = "TestRole"
  type = string
}

variable "k8s_admin_role_name" {
  default = "AdminTestRole"
  type = string
}

variable "ci_cd_profile" {
  default = "GithubAccessTest"
}

variable "local" {
  default = false
  type = bool
}

#################
# Database variables
#################
variable "dbname" {
  type = string
  default = "demodb"
}

variable "secretRDSPath" {
  default = "tutorials/rds/credentials"
  type = string
}

variable "db_username" {
  default = "user"
  type = string
}

