resource "openstack_compute_instance_v2" "Instance" {
  name = var.instance_name
  image_id        = data.openstack_images_image_v2.image.id
  flavor_id = data.openstack_compute_flavor_v2.flavor.id
  key_pair = var.keypair_name
  security_groups = var.security_groups
  network {
    name = var.network_name
  }
  timeouts {
    create = "120m"
    delete = "5m"
    }
  block_device {
    uuid                  = data.openstack_images_image_v2.image.id
    source_type           = "image"
    volume_size           = var.volume_size
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
  dynamic block_device {
    for_each = [for volume in var.volume_list: {
            boot_index = volume.boot_index
            size = volume.size
    }]
    content {
        source_type           = "blank"
        volume_size           = block_device.value.size
        boot_index            = block_device.value.boot_index
        destination_type      = "volume"
        delete_on_termination = true
    }
 }
  user_data = file("cloud-config")
}

resource "openstack_networking_floatingip_v2" "fip" {
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "fip" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  instance_id = openstack_compute_instance_v2.Instance.id
}

output "instance_ip" {
    value = openstack_compute_instance_v2.Instance.access_ip_v4
}

output "float_ip" {
    value = openstack_networking_floatingip_v2.fip.address
}
