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

output "gremlin_database_id" {
  value = try(azurerm_cosmosdb_gremlin_database.this.*.id)
}

output "gremlin_database_name" {
  value = try(azurerm_cosmosdb_gremlin_database.this.*.name)
}

output "gremlin_graph_id" {
  value = try(azurerm_cosmosdb_gremlin_graph.this.*.id)
}

output "gremlin_graph_name" {
  value = try(azurerm_cosmosdb_gremlin_graph.this.*.name)
}

output "mongo_collection_id" {
  value = try(azurerm_cosmosdb_mongo_collection.this.*.id)
}

output "mongo_collection_name" {
  value = try(azurerm_cosmosdb_mongo_collection.this.*.name)
}

output "mongo_database_id" {
  value = try(azurerm_cosmosdb_mongo_database.this.*.id)
}

output "mongo_database_name" {
  value = try(azurerm_cosmosdb_mongo_database.this.*.name)
}

output "mongo_role_definition_id" {
  value = try(azurerm_cosmosdb_mongo_role_definition.this.*.id)
}

output "mongo_role_definition_name" {
  value = try(azurerm_cosmosdb_mongo_role_definition.this.*.role_name)
}

output "mongo_user_definition_id" {
  value = try(azurerm_cosmosdb_mongo_user_definition.this.*.id)
}

output "mongo_user_definition_username" {
  value = try(azurerm_cosmosdb_mongo_user_definition.this.*.username)
  sensitive = true
}

output "mongo_user_definition_password" {
  value = try(azurerm_cosmosdb_mongo_user_definition.this.*.password)
  sensitive = true
}