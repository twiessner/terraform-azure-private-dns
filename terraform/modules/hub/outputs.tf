
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.cosmos_db.id
}

output "private_dns_zone_name" {
  value = azurerm_private_dns_zone.cosmos_db.name
}

output "resource_group_name" {
  value = azurerm_resource_group.hub.name
}