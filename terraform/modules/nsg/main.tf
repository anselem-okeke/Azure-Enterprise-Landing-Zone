#resource "azurerm_network_security_group" "this" {
#  name                = var.name
#  location            = var.location
#  resource_group_name = var.resource_group_name
#  tags                = var.tags
#}
#
#resource "azurerm_network_security_rule" "this" {
#  for_each = {
#    for rule in var.security_rules : rule.name => rule
#  }
#
#  name                        = each.value.name
#  priority                    = each.value.priority
#  direction                   = each.value.direction
#  access                      = each.value.access
#  protocol                    = each.value.protocol
#  source_port_range           = each.value.source_port_range
#  destination_port_range      = each.value.destination_port_range
#  source_address_prefix       = each.value.source_address_prefix
#  destination_address_prefix  = each.value.destination_address_prefix
#  resource_group_name         = var.resource_group_name
#  network_security_group_name = azurerm_network_security_group.this.name
#}

resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "managed" {
  for_each = {
    for rule in var.security_rules : rule.name => rule
    if rule.name != "allow-ssh-from-trusted-ip"
  }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

resource "azurerm_network_security_rule" "ssh_trusted_ip" {
  for_each = {
    for rule in var.security_rules : rule.name => rule
    if rule.name == "allow-ssh-from-trusted-ip"
  }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name

  lifecycle {
    ignore_changes = [
      source_address_prefix
    ]
  }
}

moved {
  from = azurerm_network_security_rule.this["allow-ssh-from-trusted-ip"]
  to   = azurerm_network_security_rule.ssh_trusted_ip["allow-ssh-from-trusted-ip"]
}

moved {
  from = azurerm_network_security_rule.this["deny-internet-admin-access"]
  to   = azurerm_network_security_rule.managed["deny-internet-admin-access"]
}