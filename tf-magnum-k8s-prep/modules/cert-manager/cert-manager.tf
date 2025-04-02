## Install Cert-Manager helm with values
resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = var.cert_manager_namespace
  create_namespace = true
  wait             = true
  reset_values     = true
  max_history      = 3

  values = [
    templatefile("${path.module}/helm_values/cert-manager-values.yml", {
    })
  ]
}

### Cloudflare token secret for Cert manager
resource "kubectl_manifest" "cloudflare_token_secret" {
    yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-token-secret
  namespace: cert-manager
type: Opaque
stringData:
  cloudflare-token: "${var.cloudflare_token}"
YAML

  depends_on = [
    helm_release.cert-manager
  ]
}

### Letsencrypt staging cluster issuers
resource "kubectl_manifest" "le_staging_cluster_issuers" {
    count = var.create_le_staging ? 1 : 0
    yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: "${var.le_email}"
    privateKeySecretRef:
      name: letsencrypt-staging
    solvers:
      - dns01:
          cloudflare:
            email: "${var.le_email}"
            apiTokenSecretRef:
              name: cloudflare-token-secret
              key: cloudflare-token
        selector:
          dnsZones:
            - "${var.dns_zone_name}"
YAML
  depends_on = [
    helm_release.cert-manager
  ]
}

### Letsencrypt Staging Certificate for tritec.in
resource "kubectl_manifest" "le_staging_tritec_crt" {
    count = var.create_le_staging ? 1 : 0
    yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: staging-tritec-in
  namespace: default
spec:
  secretName: tritec-in-staging-tls
  issuerRef:
    name: letsencrypt-staging
    kind: ClusterIssuer
  commonName: "${var.wildcard_domain}"
  dnsNames:
  - "${var.dns_zone_name}"
  - "${var.wildcard_domain}"
YAML
    depends_on = [
      helm_release.cert-manager
    ]
}

## Create Cert manager letsencrypt Production cluster issuers
resource "kubectl_manifest" "le_prod_cluster_issuers" {
    count = var.create_le_prod ? 1 : 0
    yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-production
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: "${var.le_email}"
    privateKeySecretRef:
      name: letsencrypt-production
    solvers:
      - dns01:
          cloudflare:
            email: "${var.le_email}"
            apiTokenSecretRef:
              name: cloudflare-token-secret
              key: cloudflare-token
        selector:
          dnsZones:
            - "${var.dns_zone_name}"
YAML
  depends_on = [
    helm_release.cert-manager
  ]
}

## Create letsencrypt Production certficate in default namespace for tritec.in domain
resource "kubectl_manifest" "le_prod_tritec_crt" {
    count = var.create_le_prod ? 1 : 0
    yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: production-tritec-in
  namespace: default
spec:
  secretName: tritec-in-production-tls
  issuerRef:
    name: letsencrypt-production
    kind: ClusterIssuer
  commonName: "${var.wildcard_domain}"
  dnsNames:
  - "${var.dns_zone_name}"
  - "${var.wildcard_domain}"
YAML
    depends_on = [
      helm_release.cert-manager
    ]
}


