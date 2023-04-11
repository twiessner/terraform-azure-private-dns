
module "hub" {
  source = "./modules/hub"

  location = var.location
  workload = var.workload
}

module "spoke" {
  source = "./modules/spoke"

  location = var.location
  workload = var.workload

  private_dns_zone_id   = module.hub.private_dns_zone_id
  private_dns_zone_name = module.hub.private_dns_zone_name
}

resource "azurerm_virtual_network_peering" "hub-to-spoke" {
  name                      = "hub-to-spoke"
  resource_group_name       = module.hub.resource_group_name
  virtual_network_name      = module.hub.vnet_name
  remote_virtual_network_id = module.spoke.vnet_id

  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "spoke-to-hub" {
  name                      = "spoke-to-hub"
  resource_group_name       = module.spoke.resource_group_name
  virtual_network_name      = module.spoke.vnet_name
  remote_virtual_network_id = module.hub.vnet_id

  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}
