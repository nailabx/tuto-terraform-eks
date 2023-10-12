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

#outputs.tf
output "security_group_id" {
  description = "AWS DB security group"
  value       = aws_security_group.rds.id
}

output "db_instance_endpoint" {
  value       = aws_db_instance.default.endpoint
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}
