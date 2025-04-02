variable "cloud_name" {
  type    = string
#  default = "os-admin"   # name and hostname of instance
}
variable "public_network_name" {
  type    = string
#  default = "public-network"   
}

variable "external_network_subnet_name" {
  type    = string
#  default = "public-subnet"   
}

variable "external_network_cidr" {
  type    = string
#  default = "192.168.16.0/24"   
}

variable "external_gateway_ip" {
  type    = string
#  default = "192.168.16.1"   
}

variable "dns_servers_ip" {
  type    = list(string)
#  default = ["192.168.16.12"]
}

variable "external_ip_pool" {
  type = map
#  default = {
#    "start_ip"  = "192.168.16.230"
#    "end_ip" = "192.168.16.249"
#    }
}

variable "external_router" {
  type    = string
#  default = "external_router"
}

variable "project_name" {
  type    = string
#  default = "tritec"
}

variable "project_description" {
  type    = string
#  default = "Tritec Project"
}

variable "project_username" {
  type    = string
#  default = "manish"
}

variable "project_user_password" {
  type    = string
#  default = "Dun1ya@007"
}

variable "role_name" {
  type    = string
#  default = "role_1"
}
