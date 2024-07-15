output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint_public_access
}

output "cluster_ca_certificate" {
  description = "The CA certificate for the EKS cluster"
  value       = module.eks.cluster_ca_certificate.certificate_authority.data
}

output "region" {
    value = var.REGION
}