resource "helm_release" "cinder-csi" {
  name             = "cinder-csi"
  repository       = "https://kubernetes.github.io/cloud-provider-openstack"
  chart            = "openstack-cinder-csi"
  version          = var.cinder_csi_chart_version
  namespace        = var.cinder_csi_namespace
  create_namespace = false
  wait             = true
  reset_values     = true
  max_history      = 3

  values = [
    templatefile("${path.module}/helm_values/cinder-helm-values.yml", {
      auth-url                           = var.cloud_conf_auth_url
      application-credential-id          = var.cloud_conf_application_cred_id
      application-credential-secret      = var.cloud_conf_application_cred_secret
    })
  ]
}

## Create Storageclass
resource "kubectl_manifest" "cinder-storageclass" {
    yaml_body = <<YAML
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: "${var.storageclass_name}"
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: cinder.csi.openstack.org
parameters:
  availability: nova
allowVolumeExpansion: true
volumeBindingMode: Immediate
YAML

  depends_on = [
    helm_release.cinder-csi
  ]
}

