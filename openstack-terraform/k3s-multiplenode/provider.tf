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
#  cloud  = "os-user" # cloud defined in cloud.yml file
   user_name = "manish"
   tenant_name = "tritec"
   password = "Dun1ya@007"
   auth_url = "https://ostack.tritec.in:5000/v3.0"
   region = "RegionOne"
}


