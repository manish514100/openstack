# Variables
variable "instance_name" {
  type    = string
  default = "asif-tomcat"   # name and hostname of instance
}

variable "keypair" {
  type    = string
  default = "asifkey"   # name of keypair created 
}

variable "network" {
  type    = string
  default = "private-network" # default network to be used
}

variable "security_groups" {
  type    = list(string)
  default = ["my-security-group"]  # Name of default security group
}

variable "volume_size" {
  type = number
  default = 30
}


# Data sources
## Get Image ID
data "openstack_images_image_v2" "image" {
  name        = "ubuntu2204-image" # Name of image to be used
  most_recent = true
}

## Get flavor id
data "openstack_compute_flavor_v2" "flavor" {
  name = "os.medium" # flavor to be used
}

