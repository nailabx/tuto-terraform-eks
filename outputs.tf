output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_name
}

output "cluster_id" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_id
}
