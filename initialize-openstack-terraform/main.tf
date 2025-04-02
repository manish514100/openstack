module "admin" {
    source        = "./modules/admin"
    providers = {
    openstack = openstack.admin
     }
    cloud_name           = "os-admin"
    public_network_name     = "public-network"
    external_network_subnet_name = "public-subnet"
    external_network_cidr = "192.168.16.0/24"
    external_gateway_ip = "192.168.16.1"
    dns_servers_ip = ["192.168.16.12"]
    external_ip_pool = {
        "start_ip"  = "192.168.16.225"
        "end_ip" = "192.168.16.239"
    }
    external_router = "external_router"
    project_name    = "tritec"
    project_description = "Tritec Project"
    project_username   = "manish"
    project_user_password = var.project_user_password
    role_name       = "role_1"

#    depends_on = [module.metallb]
}

module "project" {
    source        = "./modules/project"
    providers = {
    openstack = openstack.user
     }

    cloud_name           = "os-user"
    private_network_name     = "private-network"
    private_network_subnet_name = "private-subnet"
    private_network_cidr = "10.20.30.0/24"
    private_gateway_ip = "10.20.30.1"
    dns_servers_ip = ["192.168.16.12"]

    private_router = "private_router"
    sg_name    = "my-security-group"
    ssh_key_name = "mykey"
    ssh_pub_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5zKpUsVC4MDIbFxmcR0s2QHFpL8WXKv0uCDmN17nlJjgb8O3XB1zwM2wPj9RQJPmtQ5W2aiI9xtraHoYXGmb0GTjgJHvQBBTUVo+VyZeTMidXjs1704x62IB6i+jh/ROjWDcgZoOUaab1bNWlHF/aWkIZ5bnwvTkuopJ6ZVPhsVCUQeSb5Uxqmuw7jm4xDlaYBRjUs6EkiWOxH3f/y27SwVOtqj36j43zDAn7xz3ZkI01YjVQk7sDNMc7802NooBsvKRs2+T4OmtUJijnV1p7RzI9dGsgmkRcwJQlyPa0nGRiE1k8xRtV+Aha15ZL5oksHdz83G4xKrxlB06Qppmcmcz5Fwcyswk58Gt7ZmB2b9TSgSZ6BNahk3PUXmbPqSr+/vhMah7BrrvGcReAMf3etsE56/9HDsiuEH/z2H9dA19RxkC19/r8I2mfz/R5YuoSsxt6Z1qA+ccxkgrez1W05FigjEhce96A9OLLW1bWu88XbeKzdo/Kn0JVEg0ztuk= manish@manish-office"

    depends_on = [module.admin]
}

module "cirros" {
    source        = "./modules/cirros-instance"
    providers = {
    openstack = openstack.user
     }

    cloud_name           = "os-user"
    instance_name     = "cirros"
    keypair = "mykey"
    instance_security_groups = ["my-security-group"]
    network = "private-network"
    volume_size = 1

    depends_on = [module.project]
}
