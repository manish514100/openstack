module "cinder" {
    source        = "./modules/cinder"
    
    kube_config          = "~/.kube/config"
    cinder_csi_namespace = "kube-system"
    cinder_csi_chart_version = "2.27.1"
    cloud_conf_auth_url = "https://ostack.tritec.in:5000"
    cloud_conf_application_cred_id = var.cloud_conf_application_cred_id
    cloud_conf_application_cred_secret = var.cloud_conf_application_cred_secret
    storageclass_name = "cinder"

}

module "traefik" {
    source        = "./modules/traefik"

    kube_config           = "~/.kube/config"
    traefik_namespace     = "traefik"
    traefik_chart_version = "23.0.1"
    traefik_dashboard_url = "Host(`traefik.tritec.in`)"
    traefik_admin_pass    = var.traefik_admin_pass

    depends_on = [module.cinder]
}

module "cert-manager" {
    source        = "./modules/cert-manager"

    kube_config           = "~/.kube/config"
    cert_manager_namespace = "cert-manager"
    cloudflare_token      = var.cloudflare_token
    le_email              = var.le_email
    dns_zone_name         = "tritec.in"
    wildcard_domain       = "*.tritec.in"
    create_le_staging     = true
    create_le_prod        = false

    depends_on = [module.traefik]
}
