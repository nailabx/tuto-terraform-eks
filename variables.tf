variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "cluster_name" {
  default     = "gitlab-terraform-eks"
  description = "EKS Cluster name"
}

variable "cluster_version" {
  default     = "1.27"
  description = "Kubernetes version"
}

variable "instance_type" {
  default     = "t3.xlarge"
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

