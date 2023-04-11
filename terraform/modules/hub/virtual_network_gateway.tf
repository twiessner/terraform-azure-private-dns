
data "azurerm_client_config" "current" {
}

resource "azurerm_public_ip" "gateway" {
  name                = join("-", ["pip", var.workload, var.location.short])
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "gateway" {
  name                = join("-", ["vgw", var.workload, var.location.short])
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.gateway.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }

  vpn_client_configuration {
    address_space = ["10.2.0.0/24"]

    aad_audience = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
    aad_issuer   = "https://sts.windows.net/${data.azurerm_client_config.current.tenant_id}/"
    aad_tenant   = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/"

    vpn_auth_types       = ["AAD"]
    vpn_client_protocols = ["OpenVPN"]
  }
}