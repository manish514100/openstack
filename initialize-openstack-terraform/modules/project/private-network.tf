resource "openstack_networking_network_v2" "private-network" {
  name           = var.private_network_name
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "private-subnet" {
  name            = var.private_network_subnet_name
  network_id      = openstack_networking_network_v2.private-network.id
  cidr            = var.private_network_cidr
  gateway_ip      = var.private_gateway_ip
  dns_nameservers = var.dns_servers_ip
}



