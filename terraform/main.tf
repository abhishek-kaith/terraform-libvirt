module "network" {
  source = "./modules/network"

  network_name   = var.network_name
  network_domain = var.network_domain
}

module "k8s-control-plane" {
  source = "./modules/k8s-control-plane"

  network_id = module.network.network_id
  network_name   = var.network_name
  image          = var.control-image
  number         = var.control-number
  vcpus          = var.control-vcpus
  memory         = var.control-memory
  volume-prefix  = var.control-volume-prefix
  size           = var.control-volume-size
  ssh-public-key = var.ssh-public-key

  depends_on = [module.network]
}


module "k8s-nodes" {
  source = "./modules/k8s-nodes"

  network_id     = module.network.network_id
  network_name   = var.network_name
  image          = var.nodes-image
  number         = var.nodes-number
  vcpus          = var.nodes-vcpus
  memory         = var.nodes-memory
  volume-prefix  = var.nodes-volume-prefix
  size           = var.nodes-volume-size
  ssh-public-key = var.ssh-public-key

  depends_on = [module.network]
}
