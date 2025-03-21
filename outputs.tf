output "cosmosdb_account_id" {
  value = try(azurerm_cosmosdb_account.this.*.id)
}

output "cosmosdb_account_name" {
  value = try(azurerm_cosmosdb_account.this.*.name)
}

output "cosmosdb_account_primary_key" {
  value = try(azurerm_cosmosdb_account.this.*.primary_key)
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

output "sql_container_id" {
  value = try(azurerm_cosmosdb_sql_container.this.*.id)
}

output "sql_container_name" {
  value = try(azurerm_cosmosdb_sql_container.this.*.name)
}

output "sql_database_id" {
  value = try(azurerm_cosmosdb_sql_database.this.*.id)
}

output "sql_role_definition_id" {
  value = try(azurerm_cosmosdb_sql_role_definition.this.*.id)
}

output "sql_role_definition_name" {
  value = try(azurerm_cosmosdb_sql_role_definition.this.*.name)
}

output "sql_dedicated_gateway_id" {
  value = try(azurerm_cosmosdb_sql_dedicated_gateway.this.*.id)
}

output "sql_function_id" {
  value = try(azurerm_cosmosdb_sql_function.this.*.id)
}

output "sql_function_name" {
  value = try(azurerm_cosmosdb_sql_function.this.*.name)
}

output "sql_stored_procedure_id" {
  value = try(azurerm_cosmosdb_sql_stored_procedure.this.*.id)
}

output "sql_stored_procedure_name" {
  value = try(azurerm_cosmosdb_sql_stored_procedure.this.*.name)
}

output "sql_trigger_id" {
  value = try(azurerm_cosmosdb_sql_trigger.this.*.id)
}

output "sql_trigger_name" {
  value = try(azurerm_cosmosdb_sql_trigger.this.*.name)
}

output "table_id" {
  value = try(azurerm_cosmosdb_table.this.*.id)
}

output "table_name" {
  value = try(azurerm_cosmosdb_table.this.*.name)
}