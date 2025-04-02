variable "cloud_name" {
  type    = string
  default = "os-user"   # name and hostname of instance
}

variable "coe_cluster_tmpl_name" {
  type    = string
}

variable "image" {
  type    = string
}

variable "coe" {
  type    = string
}

variable "worker_flavor" {
  type    = string
}

variable "master_flavor" {
  type    = string
}

variable "dns_nameserver" {
  type    = string
}

variable "docker_volume_size" {
  type    = string
}

variable "network_driver" {
  type    = string
}

variable "fixed_private_network" {
  type    = string
}

variable "fixed_private_subnet" {
  type    = string
}

variable "external_network_id" {
  type    = string
}

variable "cloud_provider_enabled" {
  type    = string
}

variable "octavia_provider" {
  type    = string
}

variable "octavia_lb_algorithm" {
  type    = string
}

variable "keypair" {
  type    = string
}
