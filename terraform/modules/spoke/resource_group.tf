
resource "azurerm_resource_group" "spoke" {
  location = var.location.name
  name     = join("-", ["rg", "spoke", var.workload, var.location.short])
}