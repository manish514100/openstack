resource "openstack_containerinfra_clustertemplate_v1" "k8s-cluster-template" {
  name                  = var.coe_cluster_tmpl_name
  image                 = var.image
  coe                   = var.coe
  flavor                = var.worker_flavor
  master_flavor         = var.master_flavor
  dns_nameserver        = var.dns_nameserver
  docker_storage_driver = "overlay2"
  docker_volume_size    = var.docker_volume_size
  network_driver        = var.network_driver
  server_type           = "vm"
  master_lb_enabled     = false
  floating_ip_enabled   = true
  fixed_network         = var.fixed_private_network
  fixed_subnet          = var.fixed_private_subnet
  external_network_id   = var.external_network_id
  keypair_id            = var.keypair

  labels = {
    cloud_provider_enabled           = var.cloud_provider_enabled
    octavia_provider                 = var.octavia_provider
    octavia_lb_algorithm             = var.octavia_lb_algorithm
  }
}

#data "openstack_containerinfra_clustertemplate_v1" "k8s-cluster-template" {
#  name = "k8s-cluster-template"
#}

output "k8s_cluster_id" {
  value = openstack_containerinfra_clustertemplate_v1.k8s-cluster-template.id
}