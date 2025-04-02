resource "openstack_images_image_v2" "cirros-image" {
  name             = "cirros-image"
  image_source_url = "https://download.cirros-cloud.net/0.6.1/cirros-0.6.1-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility	   = "public"
}

#resource "openstack_images_image_v2" "ubuntu2004-image" {
#  name             = "ubuntu20.04-image"
#  image_source_url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
#  container_format = "bare"
#  disk_format      = "qcow2"
#  visibility       = "public"
#}

#resource "openstack_images_image_v2" "ubuntu2204-image" {
#  name             = "ubuntu22.04-image"
#  image_source_url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
#  container_format = "bare"
#  disk_format      = "qcow2"
#  visibility       = "public"
#}
