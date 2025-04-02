resource "openstack_networking_network_v2" "public-network" {
  name           = var.public_network_name
  admin_state_up = "true"
  external       = "true"
  shared         = "true"
  segments {
    network_type     = "flat"
    physical_network = "physnet1"
  }
}

resource "openstack_networking_subnet_v2" "public-subnet" {
  name            = var.external_network_subnet_name
  network_id      = openstack_networking_network_v2.public-network.id
  cidr            = var.external_network_cidr
  gateway_ip      = var.external_gateway_ip
  dns_nameservers = var.dns_servers_ip
  allocation_pool {
    start = var.external_ip_pool["start_ip"]
    end   = var.external_ip_pool["end_ip"]
  }
}
