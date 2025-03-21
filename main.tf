resource "azurerm_cosmosdb_account" "this" {
  count                                 = length(var.account)
  location                              = data.azurerm_resource_group.this.location
  name                                  = lookup(var.account[count.index], "name")
  offer_type                            = lookup(var.account[count.index], "offer_type")
  resource_group_name                   = data.azurerm_resource_group.this.name
  tags                                  = lookup(var.account[count.index], "tags")
  minimal_tls_version                   = lookup(var.account[count.index], "minimal_tls_version")
  create_mode                           = lookup(var.account[count.index], "create_mode")
  default_identity_type                 = var.user_assigned_identity_name ? join("=", ["UserAssignedIdentity", data.azurerm_user_assigned_identity.this.id]) : lookup(var.account[count.index], "default_identity_type")
  kind                                  = lookup(var.account[count.index], "kind")
  ip_range_filter                       = lookup(var.account[count.index], "ip_range_filter")
  free_tier_enabled                     = lookup(var.account[count.index], "free_tier_enabled")
  analytical_storage_enabled            = lookup(var.account[count.index], "analytical_storage_enabled")
  automatic_failover_enabled            = lookup(var.account[count.index], "automatic_failover_enabled")
  partition_merge_enabled               = lookup(var.account[count.index], "partition_merge_enabled")
  burst_capacity_enabled                = lookup(var.account[count.index], "burst_capacity_enabled")
  public_network_access_enabled         = lookup(var.account[count.index], "public_network_access_enabled")
  is_virtual_network_filter_enabled     = lookup(var.account[count.index], "is_virtual_network_filter_enabled")
  key_vault_key_id                      = var.key_vault_name ? data.azurerm_key_vault_key.this.id : element(module.keyvault.*.key_vault_key_id, lookup(var.account[count.index], "key_vault_key_id"))
  managed_hsm_key_id                    = var.managed_hardware_security_module_name ? data.azurerm_key_vault_managed_hardware_security_module_key.this.id : element(module.keyvault.*.managed_hsm_key_id, lookup(var.account[count.index], "managed_hsm_key_id"))
  multiple_write_locations_enabled      = lookup(var.account[count.index], "multiple_write_locations_enabled")
  access_key_metadata_writes_enabled    = lookup(var.account[count.index], "access_key_metadata_writes_enabled")
  mongo_server_version                  = lookup(var.account[count.index], "mongo_server_version")
  network_acl_bypass_for_azure_services = lookup(var.account[count.index], "network_acl_bypass_for_azure_services")
  network_acl_bypass_ids                = []
  local_authentication_disabled         = lookup(var.account[count.index], "local_authentication_disabled")

  dynamic "analytical_storage" {
    for_each = try(lookup(var.account[count.index], "analytical_storage") == null ? [] : ["analytical_storage"])
    content {
      schema_type = lookup(analytical_storage.value, "schema_type")
    }
  }

  dynamic "capabilities" {
    for_each = try(lookup(var.account[count.index], "capabilities") == null ? [] : ["capabilities"])
    content {
      name = lookup(capabilities.value, "name")
    }
  }

  dynamic "capacity" {
    for_each = try(lookup(var.account[count.index], "capacity") == null ? [] : ["capacity"])
    content {
      total_throughput_limit = lookup(capacity.value, "total_throughput_limit")
    }
  }

  dynamic "consistency_policy" {
    for_each = try(lookup(var.account[count.index], "consistency_policy") == null ? [] : ["consistency_policy"])
    content {
      consistency_level       = lookup(consistency_policy.value, "consistency_level")
      max_interval_in_seconds = lookup(consistency_policy.value, "max_interval_in_seconds")
      max_staleness_prefix    = lookup(consistency_policy.value, "max_staleness_prefix")
    }
  }

  dynamic "geo_location" {
    for_each = try(lookup(var.account[count.index], "geo_location") == null ? [] : ["geo_location"])
    content {
      failover_priority = lookup(geo_location.value, "failover_priority")
      location          = lookup(geo_location.value, "location")
      zone_redundant    = lookup(geo_location.value, "zone_redundant")
    }
  }

  dynamic "virtual_network_rule" {
    for_each = try(lookup(var.account[count.index], "virtual_network_rule") == null ? [] : ["virtual_network_rule"])
    content {
      id                                   = lookup(virtual_network_rule.value, "id")
      ignore_missing_vnet_service_endpoint = lookup(virtual_network_rule.value, "ignore_missing_vnet_service_endpoint")
    }
  }

  dynamic "backup" {
    for_each = try(lookup(var.account[count.index], "backup") == null ? [] : ["backup"])
    content {
      type                = lookup(backup.value, "type")
      tier                = lookup(backup.value, "tier")
      interval_in_minutes = lookup(backup.value, "interval_in_minutes")
      retention_in_hours  = lookup(backup.value, "retention_in_hours")
      storage_redundancy  = lookup(backup.value, "storage_redundancy")
    }
  }

  dynamic "cors_rule" {
    for_each = try(lookup(var.account[count.index], "cors_rule") == null ? [] : ["cors_rule"])
    content {
      allowed_headers    = lookup(cors_rule.value, "allowed_headers")
      allowed_methods    = lookup(cors_rule.value, "allowed_methods")
      allowed_origins    = lookup(cors_rule.value, "allowed_origins")
      exposed_headers    = lookup(cors_rule.value, "exposed_headers")
      max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds")
    }
  }

  dynamic "identity" {
    for_each = try(lookup(var.account[count.index], "identity") == null ? [] : ["identity"])
    content {
      type         = lookup(identity.value, "type")
      identity_ids = [lookup(identity.value, "type") == "UserAssigned" ? data.azurerm_user_assigned_identity.this.id : lookup(identity.value, "identity_ids")]
    }
  }

  dynamic "restore" {
    for_each = try(lookup(var.account[count.index], "restore") == null ? [] : ["restore"])
    content {
      restore_timestamp_in_utc   = lookup(restore.value, "restore_timestamp_in_utc")
      source_cosmosdb_account_id = lookup(restore.value, "source_cosmosdb_account_id")
      tables_to_restore          = lookup(restore.value, "tables_to_restore")

      dynamic "database" {
        for_each = try(lookup(restore.value, "database") == null ? [] : ["database"])
        content {
          name             = lookup(database.value, "name")
          collection_names = [lookup(database.value, "collection_names")]
        }
      }

      dynamic "gremlin_database" {
        for_each = try(lookup(restore.value, "gremlin_database") == null ? [] : ["gremlin_database"])
        content {
          name        = lookup(gremlin_database.value, "name")
          graph_names = [lookup(gremlin_database.value, "graph_names")]
        }
      }
    }
  }
}

resource "azurerm_cosmosdb_cassandra_cluster" "this" {
  count                            = length(var.cassandra_cluster)
  default_admin_password           = sensitive(lookup(var.cassandra_cluster[count.index], "default_admin_password"))
  delegated_management_subnet_id   = data.azurerm_subnet.this.id
  location                         = data.azurerm_resource_group.this.location
  name                             = lookup(var.cassandra_cluster[count.index], "name")
  resource_group_name              = data.azurerm_resource_group.this.name
  authentication_method            = lookup(var.cassandra_cluster[count.index], "authentication_method")
  external_gossip_certificate_pems = lookup(var.cassandra_cluster[count.index], "external_gossip_certificate_pems")
  external_seed_node_ip_addresses  = lookup(var.cassandra_cluster[count.index], "external_seed_node_ip_addresses")
  hours_between_backups            = lookup(var.cassandra_cluster[count.index], "hours_between_backups")
  repair_enabled                   = trulookup(var.cassandra_cluster[count.index], "repair_enabled")
  version                          = lookup(var.cassandra_cluster[count.index], "version")
  tags                             = lookup(var.cassandra_cluster[count.index], "tags")
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_cosmosdb_cassandra_datacenter" "this" {
  count                           = length(var.cassandra_cluster) == 0 ? 0 : length(var.cassandra_datacenter)
  cassandra_cluster_id            = element(azurerm_cosmosdb_cassandra_cluster.this.*.id, lookup(var.cassandra_datacenter[count.index], "cassandra_cluster_id"))
  delegated_management_subnet_id  = data.azurerm_subnet.this.id
  location                        = data.azurerm_resource_group.this.location
  name                            = lookup(var.cassandra_datacenter[count.index], "name")
  node_count                      = lookup(var.cassandra_datacenter[count.index], "node_count")
  backup_storage_customer_key_uri = lookup(var.cassandra_datacenter[count.index], "backup_storage_customer_key_uri")
  base64_encoded_yaml_fragment    = lookup(var.cassandra_datacenter[count.index], "base64_encoded_yaml_fragment")
  disk_count                      = lookup(var.cassandra_datacenter[count.index], "disk_count")
  disk_sku                        = lookup(var.cassandra_datacenter[count.index], "disk_sku")
  managed_disk_customer_key_uri   = lookup(var.cassandra_datacenter[count.index], "managed_disk_customer_key_uri")
  sku_name                        = lookup(var.cassandra_datacenter[count.index], "sku_name")
  availability_zones_enabled      = lookup(var.cassandra_datacenter[count.index], "availability_zones_enabled")
}

resource "azurerm_cosmosdb_cassandra_keyspace" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) == 0 ? 0 : length(var.cassandra_keyspace)
  account_name        = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.cassandra_keyspace[count.index], "account_id"))
  name                = lookup(var.cassandra_keyspace[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  throughput          = lookup(var.cassandra_keyspace[count.index], "throughput")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.cassandra_keyspace[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }
}

resource "azurerm_cosmosdb_cassandra_table" "this" {
  count                  = length(var.cassandra_keyspace) == 0 ? 0 : length(var.cassandra_table)
  cassandra_keyspace_id  = element(azurerm_cosmosdb_cassandra_keyspace.this.*.id, lookup(var.cassandra_table[count.index], "cassandra_keyspace_id"))
  name                   = lookup(var.cassandra_table[count.index], "name")
  throughput             = lookup(var.cassandra_table[count.index], "throughput")
  default_ttl            = lookup(var.cassandra_table[count.index], "default_ttl")
  analytical_storage_ttl = lookup(var.cassandra_table[count.index], "analytical_storage_ttl")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.cassandra_table[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }

  dynamic "schema" {
    for_each = try(lookup(var.cassandra_table[count.index], "schema") == null ? [] : ["schema"])
    content {
      dynamic "cluster_key" {
        for_each = try(lookup(schema.value, "cluster_key") == null ? [] : ["cluster_key"])
        content {
          name     = lookup(cluster_key.value, "name")
          order_by = lookup(cluster_key.value, "order_by")
        }
      }
      dynamic "column" {
        for_each = try(lookup(schema.value, "column") == null ? [] : ["column"])
        content {
          name = lookup(column.value, "name")
          type = lookup(column.value, "type")
        }
      }
      dynamic "partition_key" {
        for_each = try(lookup(schema.value, "partition_key") == null ? [] : ["partition_key"])
        content {
          name = lookup(partition_key.value, "name")
        }
      }
    }
  }
}

resource "azurerm_cosmosdb_gremlin_database" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) == 0 ? 0 : length(var.gremlin_database)
  account_name        = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.gremlin_database[count.index], "account_id"))
  name                = lookup(var.gremlin_database[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.*.name
  throughput          = lookup(var.gremlin_database[count.index], "throughput")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.gremlin_database[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }
}

resource "azurerm_cosmosdb_gremlin_graph" "this" {
  count                  = (length(var.account) || var.cosmosdb_account_name) && length(var.gremlin_database) == 0 ? 0 : length(var.gremlin_graph)
  account_name           = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.gremlin_graph[count.index], "account_id"))
  database_name          = element(azurerm_cosmosdb_gremlin_database.this.*.name, lookup(var.gremlin_graph[count.index], "database_id"))
  name                   = lookup(var.gremlin_graph[count.index], "name")
  partition_key_path     = lookup(var.gremlin_graph[count.index], "partition_key_path")
  resource_group_name    = data.azurerm_resource_group.this.name
  partition_key_version  = lookup(var.gremlin_graph[count.index], "partition_key_version")
  throughput             = lookup(var.gremlin_graph[count.index], "throughput")
  analytical_storage_ttl = lookup(var.gremlin_graph[count.index], "analytical_storage_ttl")
  default_ttl            = lookup(var.gremlin_graph[count.index], "default_ttl")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.gremlin_graph[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }

  dynamic "index_policy" {
    for_each = try(lookup(var.gremlin_graph[count.index], "index_policy") == null ? [] : ["index_policy"])
    content {
      indexing_mode  = lookup(index_policy.value, "indexing_mode")
      automatic      = lookup(index_policy.value, "automatic")
      included_paths = lookup(index_policy.value, "included_paths")
      excluded_paths = lookup(index_policy.value, "excluded_paths")

      dynamic "composite_index" {
        for_each = try(lookup(index_policy.value, "composite_index") == null ? [] : ["composite_index"])
        content {
          dynamic "index" {
            for_each = try(lookup(composite_index.value, "index") == null ? [] : ["index"])
            content {
              order = lookup(index.value, "order")
              path  = lookup(index.value, "path")
            }
          }
        }
      }

      dynamic "spatial_index" {
        for_each = try(lookup(index_policy.value, "spatial_index") == null ? [] : ["spatial_index"])
        content {
          path = lookup(spatial_index.value, "path")
        }
      }
    }
  }

  dynamic "conflict_resolution_policy" {
    for_each = try(lookup(var.gremlin_graph[count.index], "conflict_resolution_policy") == null ? [] : ["conflict_resolution_policy"])
    content {
      mode                          = lookup(conflict_resolution_policy.value, "mode")
      conflict_resolution_path      = lookup(conflict_resolution_policy.value, "conflict_resolution_path")
      conflict_resolution_procedure = lookup(conflict_resolution_policy.value, "conflict_resolution_procedure")
    }
  }

  dynamic "unique_key" {
    for_each = try(lookup(var.gremlin_graph[count.index], "unique_key") == null ? [] : ["unique_key"])
    content {
      paths = lookup(unique_key.value, "paths")
    }
  }
}

resource "azurerm_cosmosdb_mongo_collection" "this" {
  count                  = (length(var.account) || var.cosmosdb_account_name) && length(var.mongo_database) == 0 ? 0 : length(var.mongo_collection)
  account_name           = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.mongo_collection[count.index], "account_id"))
  database_name          = element(azurerm_cosmosdb_mongo_database.this.*.name, lookup(var.mongo_collection[count.index], "database_id"))
  name                   = lookup(var.mongo_collection[count.index], "name")
  resource_group_name    = data.azurerm_resource_group.this.name
  shard_key              = lookup(var.mongo_collection[count.index], "shard_key")
  analytical_storage_ttl = lookup(var.mongo_collection[count.index], "analytical_storage_ttl")
  default_ttl_seconds    = lookup(var.mongo_collection[count.index], "default_ttl_seconds")
  throughput             = lookup(var.mongo_collection[count.index], "throughput")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.mongo_collection[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }

  dynamic "index" {
    for_each = try(lookup(var.mongo_collection[count.index], "index") == null ? [] : ["index"])
    content {
      keys   = lookup(index.value, "keys")
      unique = lookup(index.value, "unique")
    }
  }

}

resource "azurerm_cosmosdb_mongo_database" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) == 0 ? 0 : length(var.mongo_database)
  account_name        = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.mongo_database[count.index], "account_id"))
  name                = lookup(var.mongo_database[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  throughput          = lookup(var.gremlin_database[count.index], "throughput")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.gremlin_database[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }
}

resource "azurerm_cosmosdb_mongo_role_definition" "this" {
  count                    = length(var.mongo_database) == 0 ? 0 : length(var.mongo_role_definition)
  cosmos_mongo_database_id = element(azurerm_cosmosdb_mongo_database.this.*.id, lookup(var.mongo_role_definition[count.index], "cosmos_mongo_database_id"))
  role_name                = lookup(var.mongo_role_definition[count.index], "role_name")
  inherited_role_names     = lookup(var.mongo_role_definition[count.index], "inherited_role_names")

  dynamic "privilege" {
    for_each = try(lookup(var.mongo_role_definition[count.index], "privilege") == null ? [] : ["privilege"])
    content {
      actions = lookup(privilege.value, "actions")

      dynamic "resource" {
        for_each = lookup(privilege.value, "resource")
        content {
          collection_name = lookup(resource.value, "collection_name")
          db_name         = lookup(resource.value, "db_name")
        }
      }
    }
  }
}

resource "azurerm_cosmosdb_mongo_user_definition" "this" {
  count                    = length(var.mongo_database) == 0 ? 0 : length(var.mongo_user_definition)
  cosmos_mongo_database_id = element(azurerm_cosmosdb_mongo_database.this.*.id, lookup(var.mongo_user_definition[count.index], "cosmos_mongo_database_id"))
  password                 = sensitive(lookup(var.mongo_user_definition[count.index], "password"))
  username                 = sensitive(lookup(var.mongo_user_definition[count.index], "username"))
  inherited_role_names     = lookup(var.mongo_user_definition[count.index], "inherited_role_names")
}

resource "azurerm_cosmosdb_postgresql_cluster" "this" {
  count                                = length(var.postgresql_cluster)
  location                             = data.azurerm_resource_group.this.location
  name                                 = lookup(var.postgresql_cluster[count.index], "name")
  node_count                           = lookup(var.postgresql_cluster[count.index], "node_count")
  resource_group_name                  = data.azurerm_resource_group.this.name
  administrator_login_password         = lookup(var.postgresql_cluster[count.index], "administrator_login_password")
  citus_version                        = lookup(var.postgresql_cluster[count.index], "citus_version")
  coordinator_public_ip_access_enabled = lookup(var.postgresql_cluster[count.index], "coordinator_public_ip_access_enabled")
  coordinator_server_edition           = lookup(var.postgresql_cluster[count.index], "coordinator_server_edition")
  coordinator_storage_quota_in_mb      = lookup(var.postgresql_cluster[count.index], "coordinator_storage_quota_in_mb")
  coordinator_vcore_count              = lookup(var.postgresql_cluster[count.index], "coordinator_vcore_count")
  ha_enabled                           = lookup(var.postgresql_cluster[count.index], "ha_enabled")
  node_public_ip_access_enabled        = lookup(var.postgresql_cluster[count.index], "node_public_ip_access_enabled")
  node_server_edition                  = lookup(var.postgresql_cluster[count.index], "node_server_edition")
  node_storage_quota_in_mb             = lookup(var.postgresql_cluster[count.index], "node_storage_quota_in_mb")
  node_vcores                          = lookup(var.postgresql_cluster[count.index], "node_vcores")
  point_in_time_in_utc                 = lookup(var.postgresql_cluster[count.index], "point_in_time_in_utc")
  preferred_primary_zone               = lookup(var.postgresql_cluster[count.index], "preferred_primary_zone")
  shards_on_coordinator_enabled        = lookup(var.postgresql_cluster[count.index], "shards_on_coordinator_enabled")
  source_location                      = lookup(var.postgresql_cluster[count.index], "source_location")
  source_resource_id                   = lookup(var.postgresql_cluster[count.index], "source_resource_id")
  sql_version                          = lookup(var.postgresql_cluster[count.index], "sql_version")
  tags                                 = lookup(var.postgresql_cluster[count.index], "tags")
}

resource "azurerm_cosmosdb_postgresql_coordinator_configuration" "this" {
  count      = length(var.postgresql_cluster) == 0 ? 0 : length(var.postgresql_coordinator_configuration)
  cluster_id = element(azurerm_cosmosdb_postgresql_cluster.this.*.id, lookup(var.postgresql_coordinator_configuration[count.index], "cluster_id"))
  name       = lookup(var.postgresql_coordinator_configuration[count.index], "name")
  value      = lookup(var.postgresql_coordinator_configuration[count.index], "value")
}

resource "azurerm_cosmosdb_postgresql_firewall_rule" "this" {
  count            = length(var.postgresql_cluster) == 0 ? 0 : length(var.postgresql_firewall_rule)
  cluster_id       = element(azurerm_cosmosdb_postgresql_cluster.this.*.id, lookup(var.postgresql_firewall_rule[count.index], "cluster_id"))
  end_ip_address   = lookup(var.postgresql_firewall_rule[count.index], "end_ip_address")
  name             = lookup(var.postgresql_firewall_rule[count.index], "name")
  start_ip_address = lookup(var.postgresql_firewall_rule[count.index], "start_ip_address")
}

resource "azurerm_cosmosdb_postgresql_node_configuration" "this" {
  count      = length(var.postgresql_cluster) == 0 ? 0 : length(var.postgresql_node_configuration)
  cluster_id = element(azurerm_cosmosdb_postgresql_cluster.this.*.id, lookup(var.postgresql_node_configuration[count.index], "cluster_id"))
  name       = lookup(var.postgresql_node_configuration[count.index], "name")
  value      = lookup(var.postgresql_node_configuration[count.index], "value")
}

resource "azurerm_cosmosdb_postgresql_role" "this" {
  count      = length(var.postgresql_cluster) == 0 ? 0 : length(var.postgresql_role)
  cluster_id = element(azurerm_cosmosdb_postgresql_cluster.this.*.id, lookup(var.postgresql_role[count.index], "cluster_id"))
  name       = lookup(var.postgresql_role[count.index], "name")
  password   = sensitive(lookup(var.postgresql_role[count.index], "password"))
}

resource "azurerm_cosmosdb_sql_container" "this" {
  count                  = (length(var.account) || var.cosmosdb_account_name) && length(var.sql_database) == 0 ? 0 : length(var.sql_container)
  account_name           = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.sql_container[count.index], "account_id"))
  database_name          = element(azurerm_cosmosdb_sql_database.this.*.name, lookup(var.sql_container[count.index], "database_id"))
  name                   = lookup(var.sql_container[count.index], "name")
  partition_key_paths    = lookup(var.sql_container[count.index], "partition_key_paths")
  resource_group_name    = data.azurerm_resource_group.this.name
  partition_key_kind     = lookup(var.sql_container[count.index], "partition_key_kind")
  partition_key_version  = lookup(var.sql_container[count.index], "partition_key_version")
  default_ttl            = lookup(var.sql_container[count.index], "default_ttl")
  analytical_storage_ttl = lookup(var.sql_container[count.index], "analytical_storage_ttl")
  throughput             = lookup(var.sql_container[count.index], "throughput")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.sql_container[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }

  dynamic "conflict_resolution_policy" {
    for_each = try(lookup(var.sql_container[count.index], "conflict_resolution_policy") == null ? [] : ["conflict_resolution_policy"])
    content {
      mode                          = lookup(conflict_resolution_policy.value, "mode")
      conflict_resolution_path      = lookup(conflict_resolution_policy.value, "conflict_resolution_path")
      conflict_resolution_procedure = lookup(conflict_resolution_policy.value, "conflict_resolution_procedure")
    }
  }

  dynamic "indexing_policy" {
    for_each = try(lookup(var.sql_container[count.index], "indexing_policy") == null ? [] : ["indexing_policy"])
    content {
      indexing_mode = lookup(indexing_policy.value, "indexing_mode")

      dynamic "included_path" {
        for_each = try(lookup(indexing_policy.value, "included_path") == null ? [] : ["included_path"])
        content {
          path = lookup(included_path.value, "path")
        }
      }

      dynamic "composite_index" {
        for_each = try(lookup(indexing_policy.value, "composite_index") == null ? [] : ["composite_index"])
        content {
          dynamic "index" {
            for_each = lookup(composite_index.value, "index")
            content {
              order = lookup(index.value, "order")
              path  = lookup(index.value, "path")
            }
          }
        }
      }

      dynamic "spatial_index" {
        for_each = try(lookup(indexing_policy.value, "spatial_index") == null ? [] : ["spatial_index"])
        content {
          path = lookup(spatial_index.value, "path")
        }
      }
    }
  }

  dynamic "unique_key" {
    for_each = try(lookup(var.sql_container[count.index], "unique_key") == null ? [] : ["unique_key"])
    content {
      paths = lookup(unique_key.value, "paths")
    }
  }
}

resource "azurerm_cosmosdb_sql_database" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) && length(var.sql_database) == 0 ? 0 : length(var.sql_database)
  account_name        = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.sql_database[count.index], "account_id"))
  name                = lookup(var.sql_database[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  throughput          = lookup(var.sql_database[count.index], "throughput")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.sql_database[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }
}

resource "azurerm_cosmosdb_sql_dedicated_gateway" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) == 0 ? 0 : length(var.sql_dedicated_gateway)
  cosmosdb_account_id = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.sql_dedicated_gateway[count.index], "account_id"))
  instance_count      = lookup(azurerm_cosmosdb_sql_dedicated_gateway[count.index], "instance_count")
  instance_size       = lookup(azurerm_cosmosdb_sql_dedicated_gateway[count.index], "instance_size")
}

resource "azurerm_cosmosdb_sql_function" "this" {
  count        = length(var.sql_container) == 0 ? 0 : length(var.sql_function)
  body         = lookup(var.sql_function[count.index], "body")
  container_id = element(azurerm_cosmosdb_sql_container.this.*.id, lookup(var.sql_function[count.index], "container_id"))
  name         = lookup(var.sql_function[count.index], "name")
}

resource "azurerm_cosmosdb_sql_role_assignment" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) && length(var.sql_database) && length(var.sql_role_definition) == 0 ? 0 : length(var.sql_role_assignment)
  account_name        = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.sql_role_assignment[count.index], "account_id"))
  principal_id        = data.azurerm_client_config.this.object_id
  resource_group_name = data.azurerm_resource_group.this.name
  role_definition_id  = element(azurerm_cosmosdb_sql_role_definition.this.*.id, lookup(var.sql_role_assignment[count.index], "role_definition_id"))
  scope               = lookup(var.sql_role_assignment[count.index], "scope")
  name                = lookup(var.sql_role_assignment[count.index], "name")
}

resource "azurerm_cosmosdb_sql_role_definition" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) && length(var.sql_database) == 0 ? 0 : length(var.sql_role_definition)
  account_name        = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.sql_role_definition[count.index], "account_id"))
  assignable_scopes   = lookup(var.sql_role_definition[count.index], "assignable_scopes")
  name                = lookup(var.sql_role_definition[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  role_definition_id = lookup(var.sql_role_definition[count.index], "role_definition_id")
  type = lookup(var.sql_role_definition[count.index], "type")

  dynamic "permissions" {
    for_each = lookup(var.sql_role_definition[count.index], "permissions")
    content {
      data_actions = lookup(permissions.value, "data_actions")
    }
  }
}

resource "azurerm_cosmosdb_sql_stored_procedure" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) && length(var.sql_database) && length(var.sql_container) == 0 ? 0 : length(var.sql_stored_procedure)
  account_name        = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.sql_stored_procedure[count.index], "account_id"))
  body                = lookup(var.sql_stored_procedure[count.index], "body")
  container_name      = element(azurerm_cosmosdb_sql_container.this.*.name, lookup(var.sql_stored_procedure[count.index], "container_id"))
  database_name       = element(azurerm_cosmosdb_sql_database.this.*.name, lookup(var.sql_stored_procedure[count.index], "database_id"))
  name                = lookup(var.sql_stored_procedure[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_cosmosdb_sql_trigger" "this" {
  count        = length(var.sql_container) == 0 ? 0 : length(var.sql_trigger)
  body         = lookup(var.sql_trigger[count.index], "body")
  container_id = element(azurerm_cosmosdb_sql_container.this.*.id, lookup(var.sql_trigger[count.index], "container_id"))
  name         = lookup(var.sql_trigger[count.index], "name")
  operation    = lookup(var.sql_trigger[count.index], "operation")
  type         = lookup(var.sql_trigger[count.index], "type")
}

resource "azurerm_cosmosdb_table" "this" {
  count               = (length(var.account) || var.cosmosdb_account_name) && length(var.sql_database) == 0 ? 0 : length(var.table)
  account_name        = var.cosmosdb_account_name ? data.azurerm_cosmosdb_account.this.name : element(azurerm_cosmosdb_account.this.*.name, lookup(var.table[count.index], "account_id"))
  name                = lookup(var.table[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  throughput          = lookup(var.sql_database[count.index], "throughput")

  dynamic "autoscale_settings" {
    for_each = try(lookup(var.sql_database[count.index], "autoscale_settings") == null ? [] : ["autoscale_settings"])
    content {
      max_throughput = lookup(autoscale_settings.value, "max_throughput")
    }
  }
}