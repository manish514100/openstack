## Install traefik helm with values
resource "helm_release" "traefik" {
  name             = "traefik"
  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  version          = var.traefik_chart_version
  namespace        = var.traefik_namespace
  create_namespace = true
  wait             = true
  reset_values     = true
  max_history      = 3

  values = [
    templatefile("${path.module}/helm_values/traefik-values.yml", {
    })
  ]
}

### Traefik Ingress Route
## Apply manifests for Traefik Dashboard IngressRoute
resource "kubectl_manifest" "traefik_dashboard_ingressroute" {
    yaml_body = <<YAML
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: traefik-dashboard
  namespace: traefik
  annotations: 
    kubernetes.io/ingress.class: traefik-external
spec:
  entryPoints:
    - websecure
  routes:
    - match: "${var.traefik_dashboard_url}"
      kind: Rule
      middlewares:
        - name: traefik-dashboard-basicauth
          namespace: traefik
      services:
        - name: api@internal
          kind: TraefikService
#  tls: {} ## Without secretName as it must use default traefik tls
YAML
## Apply manifests for Traefik Basic auth Middleware
  depends_on = [
    helm_release.traefik
  ]
}


### Traefik Dashboard user Authemtication Secret
resource "kubectl_manifest" "traefik_dashboard_secret" {
    yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: traefik-dashboard-auth
  namespace: traefik
type: Opaque
data:
  users: "${var.traefik_admin_pass}"
YAML

  depends_on = [
    helm_release.traefik
  ]
}


### Traefik Baisc Auth Middleware
resource "kubectl_manifest" "traefik_dashboard_basicauth_middleware" {
    yaml_body = <<YAML
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: traefik-dashboard-basicauth
  namespace: traefik
spec:
  basicAuth:
    secret: traefik-dashboard-auth
YAML

  depends_on = [
    helm_release.traefik
  ]
}


### Default headers Middleware in default namespace
resource "kubectl_manifest" "traefik_default_headers_middleware" {
    yaml_body = <<YAML
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: default-headers
  namespace: default
spec:
  headers:
    browserXssFilter: true
    contentTypeNosniff: true
    forceSTSHeader: true
    stsIncludeSubdomains: true
    stsPreload: true
    stsSeconds: 15552000
    customFrameOptionsValue: SAMEORIGIN
    customRequestHeaders:
      X-Forwarded-Proto: https
YAML

  depends_on = [
    helm_release.traefik
  ]
}

