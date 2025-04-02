# Create an instance
resource "openstack_compute_instance_v2" "server" {
#  name            = "almalinux9"  #Instance name
  name            = var.instance_name  #Instance name
  image_id        = data.openstack_images_image_v2.image.id
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  key_pair        = var.keypair
  security_groups = var.security_groups
    timeouts {
    create = "120m"
    delete = "5m"
    }
  
  user_data       = <<-EOF
    #cloud-config
    system_info:
      default_user:
        name: manish
        groups: "wheel"
        lock_passwd: false
        passwd: $6$rounds=4096$EOPPs/Z.8P7T7$h.x53qQyLix1rtIlOHzNqaO7j2iZ.4o.OOemalFRmSjNBj8QMzTxDGMz/enZA7MCoHejbs5x.5uvug9mwKrcH0
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
  EOF
  block_device {
#    uuid                  = "1b0b8f39-90b7-49a2-a80a-88b31bf6e1dd"
    uuid                  = data.openstack_images_image_v2.image.id
# this uuid here means image id, the image is rhcos scsi image
    source_type           = "image"
    volume_size           = 50
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
# for rhcos, delete_on_termination must be true, or it will fail to create instance
  }
  network {
    name = var.network
  }
}

# Add Floating ip

resource "openstack_networking_floatingip_v2" "fip1" {
  pool = "Public"
}

resource "openstack_compute_floatingip_associate_v2" "fip1" {
  floating_ip = openstack_networking_floatingip_v2.fip1.address
  instance_id = openstack_compute_instance_v2.server.id
}


# Output VM IP Address
output "serverip" {
 value = openstack_compute_instance_v2.server.access_ip_v4
}

output "server_floating_ip" {
 value = openstack_networking_floatingip_v2.fip1.address
}

