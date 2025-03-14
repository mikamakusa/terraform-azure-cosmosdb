output "cosmosdb_account_id" {
  value = try(azurerm_cosmosdb_account.this.*.id)
}

output "cosmosdb_account_name" {
  value = try(azurerm_cosmosdb_account.this.*.name)
}