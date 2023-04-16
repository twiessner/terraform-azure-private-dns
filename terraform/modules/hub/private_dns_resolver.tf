/**

resource "azurerm_private_dns_resolver" "default" {
  name                = join("-", ["dnspr", var.workload, var.location.short])
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  virtual_network_id  = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "default" {
  name                    = join("-", ["dnspr", "inbound", var.workload, var.location.short])
  private_dns_resolver_id = azurerm_private_dns_resolver.default.id
  location                = azurerm_private_dns_resolver.default.location

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.dns_inbound.id
  }
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "default" {
  name                    = join("-", ["dnspr", "inbound", var.workload, var.location.short])
  private_dns_resolver_id = azurerm_private_dns_resolver.default.id
  location                = azurerm_private_dns_resolver.default.location
  subnet_id               = azurerm_subnet.dns_outbound.id
}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "default" {
  name                = join("-", ["dnspr", "ruleset", var.workload, var.location.short])
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location

  private_dns_resolver_outbound_endpoint_ids = [
    azurerm_private_dns_resolver_outbound_endpoint.default.id
  ]
}

resource "azurerm_private_dns_resolver_virtual_network_link" "dns_forwarder" {
  name                      = "dns-forwarder-link"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.default.id
  virtual_network_id        = azurerm_virtual_network.vnet.id
}

**/