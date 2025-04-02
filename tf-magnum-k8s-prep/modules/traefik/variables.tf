variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "traefik_namespace" {
  type    = string
#  default = "traefik"
}

variable "traefik_chart_version" {
  type    = string
#  default = "23.0.1"
}

variable "traefik_dashboard_url" {
  type    = string
}

variable "traefik_admin_pass" {
  type    = string
#  default = "YWRtaW46JGFwcjEkNmIxU1VBYVYkTW04LndmMWJJVTZQQmgwb2cyNXllMAoK"      ## Traefik Dashboard admin user Password created via .htpasswd 
  sensitive = true
}
