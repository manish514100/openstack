variable "cloud_name" {
  type    = string
#  default = "os-user"   # name and hostname of instance
}

variable "private_network_name" {
  type    = string
#  default = "private-network"
}

variable "private_network_subnet_name" {
  type    = string
#  default = "private-subnet"
}

variable "private_network_cidr" {
  type    = string
#  default = "10.20.30.0/24"
}

variable "private_gateway_ip" {
  type    = string
#  default = "10.20.30.1"
}

variable "dns_servers_ip" {
  type    = list(string)
#  default = ["192.168.16.12"]
}

variable "private_router" {
  type    = string
#  default = "private_router"
}

variable "sg_name" {
  type    = string
#  default = "my-security-group"
}

variable "ssh_key_name" {
  type    = string
#  default = "mykey"
}

variable "ssh_pub_key" {
  type    = string
#  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5zKpUsVC4MDIbFxmcR0s2QHFpL8WXKv0uCDmN17nlJjgb8O3XB1zwM2wPj9RQJPmtQ5W2aiI9xtraHoYXGmb0GTjgJHvQBBTUVo+VyZeTMidXjs1704x62IB6i+jh/ROjWDcgZoOUaab1bNWlHF/aWkIZ5bnwvTkuopJ6ZVPhsVCUQeSb5Uxqmuw7jm4xDlaYBRjUs6EkiWOxH3f/y27SwVOtqj36j43zDAn7xz3ZkI01YjVQk7sDNMc7802NooBsvKRs2+T4OmtUJijnV1p7RzI9dGsgmkRcwJQlyPa0nGRiE1k8xRtV+Aha15ZL5oksHdz83G4xKrxlB06Qppmcmcz5Fwcyswk58Gt7ZmB2b9TSgSZ6BNahk3PUXmbPqSr+/vhMah7BrrvGcReAMf3etsE56/9HDsiuEH/z2H9dA19RxkC19/r8I2mfz/R5YuoSsxt6Z1qA+ccxkgrez1W05FigjEhce96A9OLLW1bWu88XbeKzdo/Kn0JVEg0ztuk= manish@manish-office"
}

## Data source
## Get public Network name
data "openstack_networking_network_v2" "external_network" {
  name = "public-network"
}

