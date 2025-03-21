data "azurerm_client_config" "this" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_user_assigned_identity" "this" {
  count               = var.user_assigned_identity_name ? 1 : 0
  name                = var.user_assigned_identity_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "this" {
  count               = var.key_vault_name ? 1 : 0
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group
}

data "azurerm_key_vault_key" "this" {
  count        = var.key_vault_key_name ? 1 : 0
  key_vault_id = data.azurerm_key_vault.this.id
  name         = var.key_vault_key_name
}

data "azurerm_key_vault_managed_hardware_security_module" "this" {
  count               = var.managed_hardware_security_module_name ? 1 : 0
  name                = var.managed_hardware_security_module_name
  resource_group_name = data.azurerm_resource_group
}

data "azurerm_key_vault_managed_hardware_security_module_key" "this" {
  count          = var.managed_hardware_security_module_key_name ? 1 : 0
  managed_hsm_id = data.azurerm_key_vault_managed_hardware_security_module.this.id
  name           = var.managed_hardware_security_module_key_name
}

data "azurerm_virtual_network" "this" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.this.name
}

data "azurerm_cosmosdb_account" "this" {
  count               = var.cosmosdb_account_name ? 1 : 0
  name                = var.cosmosdb_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}