resource "libvirt_volume" "os_image" {
  name   = "os_image"
  pool   = var.pool
  source = var.image
}

resource "libvirt_volume" "volume_qcow2" {
  count          = var.number
  name           = "${var.volume-prefix}_${count.index + 2}.qcow2"
  base_volume_id = libvirt_volume.os_image.id
  pool           = var.pool
  format         = "qcow2"
  size           = var.size
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count = var.number
  name  = "${var.volume-prefix}.commoninit-${count.index}.iso"
  pool  = var.pool
  user_data = templatefile("${path.module}/cloud_init/cloud_init-k8s-control-plane.cfg", {
    hostname       = "k8s-controllers-${count.index + 2}"
    ssh-public-key = var.ssh-public-key
  })
  network_config = templatefile("${path.module}/cloud_init/network_config-k8s-control-plane.cfg", {
    ip_address  = "10.17.3.${count.index + 2}"
    netmask     = var.netmask
    gateway     = var.gateway
    nameservers = jsonencode(var.nameservers)
  })
}


resource "libvirt_domain" "k8s-controllers" {
  count = var.number

  name   = "k8s-controllers-${count.index + 2}"
  memory = var.memory
  vcpu   = var.vcpus

  network_interface {
    network_id = var.network_id
    network_name = var.network_name
    hostname     = "k8s-controllers-${count.index + 2}"

    # Note this isn't actually used - cloud-init sets the IP
    # The address is included here for use in output.tf
    addresses = ["10.17.3.${count.index + 2}"]
  }

  disk {
    volume_id = libvirt_volume.volume_qcow2[count.index].id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
