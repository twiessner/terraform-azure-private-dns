
resource "azurerm_cosmosdb_account" "cosmos" {
  name                = join("-", ["cosmos", var.workload, var.location.short])
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name

  offer_type                    = "Standard"
  public_network_access_enabled = false

  enable_free_tier                = true
  enable_automatic_failover       = false
  enable_multiple_write_locations = false

  geo_location {
    location          = var.location.name
    failover_priority = 0
  }

  consistency_policy {
    consistency_level = "Session"
  }
}

