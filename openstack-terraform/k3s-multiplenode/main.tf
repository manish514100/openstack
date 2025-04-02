resource "openstack_compute_instance_v2" "Instance" {
  count = var.instance_num
  name = format("%s-%02d", var.instance_name, count.index+1)
  image_id        = data.openstack_images_image_v2.image.id
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  key_pair = var.keypair_name
  security_groups = var.security_groups
  network {
    name = var.network_name
    }
  timeouts {
    create = "120m"
    delete = "5m"
    }

  user_data       = file("cloud-config")


  block_device {
    uuid                  = data.openstack_images_image_v2.image.id
    source_type           = "image"
    volume_size           = var.volume_size
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
}

resource "openstack_networking_floatingip_v2" "fip" {
  count = var.instance_num
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "fip" {
  count = var.instance_num
  floating_ip = element(openstack_networking_floatingip_v2.fip.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.Instance.*.id, count.index)
}

output "instance_ips" {
    value = {
        for instance in openstack_compute_instance_v2.Instance:
         instance.name => instance.access_ip_v4
    }
}

output "float_ips" {
    value = openstack_compute_floatingip_associate_v2.fip.*.floating_ip
}

