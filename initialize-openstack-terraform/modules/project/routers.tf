resource "openstack_networking_router_v2" "private_router" {
  name                = var.private_router
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external_network.id
}

resource "openstack_networking_router_interface_v2" "int_1" {
  router_id = "${openstack_networking_router_v2.private_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.private-subnet.id}"
}
