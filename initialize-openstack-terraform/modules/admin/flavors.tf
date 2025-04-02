
resource "openstack_compute_flavor_v2" "os-tiny-flavor" {
  name      = "os.tiny"
  ram       = "512"
  vcpus     = "1"
  disk      = "1"
  flavor_id = "1"
  is_public = "true"
}
resource "openstack_compute_flavor_v2" "os-micro-flavor" {
  name      = "os.micro"
  ram       = "1024"
  vcpus     = "1"
  disk      = "5"
  flavor_id = "2"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "os-small-flavor" {
  name      = "os.small"
  ram       = "2048"
  vcpus     = "1"
  disk      = "20"
  flavor_id = "3"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "os-medium-flavor" {
  name      = "os.medium"
  ram       = "4096"
  vcpus     = "2"
  disk      = "30"
  flavor_id = "4"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "os-custom-flavor" {
  name      = "os.custom"
  ram       = "8192"
  vcpus     = "3"
  disk      = "40"
  flavor_id = "5"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "os-large-flavor" {
  name      = "os.large"
  ram       = "8192"
  vcpus     = "4"
  disk      = "40"
  flavor_id = "6"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "os-xlarge-flavor" {
  name      = "os.xlarge"
  ram       = "16384"
  vcpus     = "4"
  disk      = "50"
  flavor_id = "7"
  is_public = "true"
}
