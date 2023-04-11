
resource "azurerm_private_endpoint" "cosmos" {
  name                = join("-", ["pep", "cosmos", var.workload, var.location.short])
  location            = azurerm_cosmosdb_account.cosmos.location
  resource_group_name = azurerm_cosmosdb_account.cosmos.resource_group_name
  subnet_id           = azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "cosmos-private-service-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cosmosdb_account.cosmos.id
    subresource_names              = ["Sql"]
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_name
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}