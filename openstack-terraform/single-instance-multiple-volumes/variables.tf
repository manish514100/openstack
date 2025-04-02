variable "keypair_name" {
    description = "The keypair to be used."
    default  = "mykey"
}

variable "network_name" {
    description = "The network to be used."
    default  = "Private"
}

variable "instance_name" {
    description = "The Instance Name to be used."
    default  = "myinstance"
}

variable "floating_ip_pool" {
    description = "The pool to be used to get floating ip"
    default = "Public"
}

variable "volume_size" {
    description = "The size of volume used to instantiate the instance"
    default = 20
}

variable "security_groups" {
    description = "List of security group"
    type = list
    default = ["my-security-group"]
}

variable "volume_list" {
    description = "List of Volumes to be created"
    default = [
    {
        boot_index = 1,
        size = 20
    },
    {
        boot_index = 2,
        size = 10
    },
    {
        boot_index = 3,
        size = 10
    },
#    {
#        boot_index = 4,
#        size = 100
#    },
#    {
#        boot_index = 5,
#        size = 100
#    },
 ]
}

## Data sources for image and flavor ids.

## Get Image ID
data "openstack_images_image_v2" "image" {
  name        = "Ubunut-20.04-image" # Name of image to be used
  most_recent = true
}

## Get flavor id
data "openstack_compute_flavor_v2" "flavor" {
  name = "m1.small" # flavor to be used
}
