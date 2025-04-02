variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "cloud_conf_application_cred_id" {
  type    = string
}

variable "cloud_conf_application_cred_secret" {
  type    = string
}

variable "traefik_admin_pass" {
  type    = string
}

variable "le_email" {
  type    = string
}

variable "cloudflare_token" {
  type    = string
}