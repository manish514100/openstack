resource "openstack_compute_keypair_v2" "ssh_keypair" {
  name       = var.ssh_key_name
  public_key = var.ssh_pub_key
}
