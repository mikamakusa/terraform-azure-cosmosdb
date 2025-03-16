output "cosmosdb_account_id" {
  value = try(azurerm_cosmosdb_account.this.*.id)
}

output "cosmosdb_account_name" {
  value = try(azurerm_cosmosdb_account.this.*.name)
}

output "cassandra_cluster_id" {
  value = try(azurerm_cosmosdb_cassandra_cluster.this.*.id)
}

output "cassandra_cluster_name" {
  value = try(azurerm_cosmosdb_cassandra_cluster.this.*.name)
}

output "cassandra_datacenter_id" {
  value = try(azurerm_cosmosdb_cassandra_datacenter.this.*.id)
}

output "cassandra_datacenter_name" {
  value = try(azurerm_cosmosdb_cassandra_datacenter.this.*.name)
}

output "cassandra_keyspace_id" {
  value = try(azurerm_cosmosdb_cassandra_keyspace.this.*.id)
}

output "cassandra_keyspace_name" {
  value = try(azurerm_cosmosdb_cassandra_keyspace.this.*.name)
}

output "cassandra_table_id" {
  value = try(azurerm_cosmosdb_cassandra_table.this.*.id)
}

output "cassandra_table_name" {
  value = try(azurerm_cosmosdb_cassandra_table.this.*.name)
}