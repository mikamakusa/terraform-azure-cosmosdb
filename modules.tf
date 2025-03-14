module "keyvault" {
  source = "./modules/terraform-azure-keyvault"
  resource_group_name = var.resource_group_name
  key_vault = var.key_vault
  key_vault_key = var.key_vault_key
  managed_hardware_security_module = var.managed_hardware_security_module
  managed_hardware_security_module_key = var.managed_hardware_security_module_key
}