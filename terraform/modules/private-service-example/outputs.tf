output "key_vault_id" {
  value = azurerm_key_vault.this.id
}

output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.this.id
}

output "private_endpoint_name" {
  value = azurerm_private_endpoint.this.name
}