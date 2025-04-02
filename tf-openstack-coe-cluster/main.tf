module "coe_cluster_template" {
    source        = "./modules/k8s-cluster-templ"
    
    coe_cluster_tmpl_name = "k8s-cluster-template"
    image = "fedora-coreos-35-image"
    coe = "kubernetes"
    worker_flavor = "os.custom"
    master_flavor = "os.custom"
    dns_nameserver = "192.168.16.12"
    docker_volume_size = "20"
    network_driver  = "calico"
    fixed_private_network = "private-network"
    fixed_private_subnet = "private-subnet"
    external_network_id = "e0e097cc-298d-4343-812e-265c236fa9eb"
    keypair             = "mykey"


    ## Labels
    cloud_provider_enabled = "true"
    octavia_provider       = "ovn"
    octavia_lb_algorithm   = "SOURCE_IP_PORT"
}

output "k8s_cluster_id" {
  value = module.coe_cluster_template.k8s_cluster_id
}

module "coe_cluster" {
    source        = "./modules/k8s-cluster"

    cluster_name        = "k8s-cluster"
    master_count        = "1"
    node_count          = "3"
    keypair             = "mykey"
    cluster_template_id = module.coe_cluster_template.k8s_cluster_id
    floating_ip_enabled = "true"


    depends_on = [module.coe_cluster_template]
}