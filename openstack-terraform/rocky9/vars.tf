# Variables
variable "instance_name" {
  type    = string
  default = "rocky9"   # name and hostname of instance
}

variable "keypair" {
  type    = string
  default = "mykey"   # name of keypair created 
}

variable "network" {
  type    = string
  default = "Private" # default network to be used
}

variable "security_groups" {
  type    = list(string)
  default = ["my-security-group"]  # Name of default security group
}

variable "volume_size" {
  type = number
  default = 40
}


# Data sources
## Get Image ID
data "openstack_images_image_v2" "image" {
  name        = "rocky9-image" # Name of image to be used
  most_recent = true
}

## Get flavor id
data "openstack_compute_flavor_v2" "flavor" {
  name = "m1.medium" # flavor to be used
}

