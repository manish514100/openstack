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
    default  = "k3s"
}

variable "instance_num" {
    description = "The Number of instances to be created."
    default  = 3
}

variable "floating_ip_pool" {
    description = "The pool to be used to get floating ip"
    default = "Public"
}

variable "volume_size" {
    description = "The size of volume used to instantiate the instance"
    default = 30
}

variable "security_groups" {
    description = "List of security group"
    type = list
    default = ["k3s-sg"]
}

## Data sources for image and flavor ids.

## Get Image ID
data "openstack_images_image_v2" "image" {
  name        = "ubuntu22.04-image" # Name of image to be used
  most_recent = true
}

## Get flavor id
data "openstack_compute_flavor_v2" "flavor" {
  name = "m1.magnum" # flavor to be used
}
