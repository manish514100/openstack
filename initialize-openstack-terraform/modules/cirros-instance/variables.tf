variable "cloud_name" {
  type    = string
  default = "os-user"   # name and hostname of instance
}

variable "instance_name" {
  type    = string
#  default = "cirros"
}

variable "keypair" {
  type    = string
#  default = "mykey"   # name of keypair created
}

variable "instance_security_groups" {
  type    = list(string)
#  default = ["my-security-group"]  # Name of default security group
}

variable "network" {
  type    = string
#  default = "private-network" # default network to be used
}

variable "volume_size" {
  type    = number
#  default = 1
}

# Data sources
## Get Image ID
data "openstack_images_image_v2" "image" {
  name        = "cirros-image" # Name of image to be used
  most_recent = true
}

## Get flavor id
data "openstack_compute_flavor_v2" "flavor" {
  name = "os.tiny" # flavor to be used
}

## Get public Network name
data "openstack_networking_network_v2" "external_network" {
  name = "public-network"
}
