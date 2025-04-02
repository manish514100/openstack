resource "openstack_networking_router_v2" "external-router" {
  name                = "var.external-router"
  admin_state_up      = true
  external_network_id = openstack_networking_network_v2.public-network.id
}
