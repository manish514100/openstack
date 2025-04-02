## Helm provider
provider "helm" {
  kubernetes {
    config_path = pathexpand(var.kube_config)
}
}
## Kubernetes provoder
provider "kubernetes" {
  config_path = pathexpand(var.kube_config)
}
## Kubectl provider
terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
provider "kubectl" {
  apply_retry_count = 15
}
