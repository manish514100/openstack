resource "openstack_containerinfra_cluster_v1" "k8s-cluster" {
  name                = var.cluster_name
  cluster_template_id = var.cluster_template_id
  master_count        = var.master_count
  node_count          = var.node_count 
  keypair             = var.keypair
  floating_ip_enabled = var.floating_ip_enabled
}

#data "openstack_containerinfra_clustertemplate_v1" "k8s-cluster-template" {
#  name = "k8s-cluster-template"
#}

#output "k8s_cluster_id" {
#  value = data.openstack_containerinfra_clustertemplate_v1.k8s-cluster-template
#}