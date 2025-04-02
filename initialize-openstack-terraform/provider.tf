# Configure the OpenStack Provider
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

# Define provider for tasks

provider "openstack" {
  alias  = "admin"
  cloud  = var.cloud_name_admin # cloud defined in cloud.yml file
}

provider "openstack" {
  alias  = "user"
  cloud  = var.cloud_name_user
}