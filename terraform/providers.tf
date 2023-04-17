
provider "azurerm" {
  features {}

  tenant_id       = var.tenant_id
  subscription_id = var.hub_subscription_id
}

provider "azurerm" {
  features {}

  alias           = "spoke"
  tenant_id       = var.tenant_id
  subscription_id = var.spoke_subscription_id
}