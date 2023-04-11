
resource "azurerm_virtual_network" "vnet" {
  name                = join("-", ["vnet", var.workload, var.location.short])
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "dns_inbound" {
  name                 = join("-", ["snet", "dns", "inbound", var.location.short])
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.0.0.0/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

/**
resource "azurerm_subnet" "dns_outbound" {
  name                 = join("-", ["snet", "dns", "bound", var.location.short, "001"])
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.0.0.64/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}
**/