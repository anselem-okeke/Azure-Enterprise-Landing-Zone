resource "azurerm_postgresql_flexible_server" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.postgres_version
  administrator_login           = var.administrator_login
  administrator_password        = var.administrator_password
  storage_mb                    = var.storage_mb
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_access

  dynamic "high_availability" {
    for_each = []
    content {}
  }

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "this" {
  for_each = {
    for rule in var.firewall_rules : rule.name => rule
  }

  name             = each.value.name
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}
