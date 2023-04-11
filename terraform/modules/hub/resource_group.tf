
resource "azurerm_resource_group" "hub" {
  location = var.location.name
  name     = join("-", ["rg", "hub", var.workload, var.location.short])
}