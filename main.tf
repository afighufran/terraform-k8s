# ==========================================
# Resource Block Control Plane
# ==========================================
resource "vsphere_virtual_machine" "control-plane" {
  count            = var.master_count
  name             = "control-plane-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.master_cpu
  memory   = var.master_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "control-plane-${count.index + 1}"
        domain    = var.domain_name
      }

      network_interface {
        ipv4_address = var.master_ips[count.index]
        ipv4_netmask = var.network_netmask
      }

      ipv4_gateway    = var.network_gateway
      dns_server_list = var.dns_server
    }
  }
  lifecycle {
    prevent_destroy = true
  }
}

# ==========================================
# Resource Block Worker Plane
# ==========================================
resource "vsphere_virtual_machine" "worker-plane" {
  count            = var.worker_count
  name             = "worker-plane-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.worker_cpu
  memory   = var.worker_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "worker-plane-${count.index + 1}"
        domain    = var.domain_name
      }

      network_interface {
        ipv4_address = var.worker_ips[count.index]
        ipv4_netmask = var.network_netmask
      }

      ipv4_gateway    = var.network_gateway
      dns_server_list = var.dns_server
    }
  }
}