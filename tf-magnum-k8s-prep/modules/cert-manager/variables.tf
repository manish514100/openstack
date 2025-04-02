variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "cloudflare_token" {
  type    = string
  sensitive = true
}

variable "cert_manager_namespace" {
  type    = string
}

variable "le_email" {
  type    = string
}

variable "dns_zone_name" {
  type    = string
}

variable "wildcard_domain" {
  type    = string
}

variable "create_le_staging" {
  type    = bool
}

variable "create_le_prod" {
  type    = bool
}
