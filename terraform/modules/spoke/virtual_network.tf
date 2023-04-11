
resource "azurerm_virtual_network" "vnet" {
  name                = join("-", ["vnet", var.workload, var.location.short])
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name

  address_space = ["172.16.0.0/20"]
}

resource "azurerm_subnet" "private_endpoint" {
  name                 = join("-", ["snet", "endpoints", var.location.short])
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["172.16.0.0/28"]

  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = false
}

resource "azurerm_subnet" "function_app" {
  name                 = join("-", ["snet", "function", var.location.short])
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["172.16.0.128/28"]

  delegation {
    name = join("-", ["function", "app", "001"])

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}