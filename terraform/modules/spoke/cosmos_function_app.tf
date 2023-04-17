
resource "random_string" "cosmos_client_storage" {
  length = 20

  upper   = false
  lower   = true
  special = false

  keepers = {
    location            = var.location.name
    workload            = var.workload
    resource_group_name = azurerm_resource_group.spoke.name
  }
}

resource "azurerm_storage_account" "cosmos_client" {
  name                     = random_string.cosmos_client_storage.result
  resource_group_name      = azurerm_resource_group.spoke.name
  location                 = azurerm_resource_group.spoke.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "cosmos_client" {
  name                = join("-", ["asp", var.workload, var.location.short])
  resource_group_name = azurerm_resource_group.spoke.name
  location            = azurerm_resource_group.spoke.location

  os_type    = "Linux"
  sku_name   = "S1"
}

resource "azurerm_linux_function_app" "cosmos_client" {
  name                = join("-", ["func", var.workload, var.location.short])
  resource_group_name = azurerm_resource_group.spoke.name
  location            = azurerm_resource_group.spoke.location

  storage_account_name       = azurerm_storage_account.cosmos_client.name
  storage_account_access_key = azurerm_storage_account.cosmos_client.primary_access_key

  service_plan_id = azurerm_service_plan.cosmos_client.id

  https_only                = true
  virtual_network_subnet_id = azurerm_subnet.function_app.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      node_version = "18"
    }
  }

  app_settings = {
    # App settings
    COSMOS_DB_KEY      = azurerm_cosmosdb_account.cosmos.primary_key
    COSMOS_DB_NAME     = "nodejs-client-test"
    COSMOS_DB_ENDPOINT = azurerm_cosmosdb_account.cosmos.endpoint
    # Common settings
    WEBSITE_DNS_SERVER     = "168.63.129.16"
    WEBSITE_VNET_ROUTE_ALL = "1"
  }
}