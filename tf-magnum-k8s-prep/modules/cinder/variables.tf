variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "cinder_csi_namespace" {
  type    = string
}

variable "cinder_csi_chart_version" {
  type    = string
}

variable "cloud_conf_auth_url" {
  type    = string
  sensitive = true
}

variable "cloud_conf_application_cred_id" {
  type    = string
  sensitive = true
}

variable "cloud_conf_application_cred_secret" {
  type    = string
  sensitive = true
}

variable "storageclass_name" {
  type    = string

}