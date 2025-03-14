resource "azurerm_cosmosdb_account" "this" {
  count = length(var.account)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.account[count.index], "name")
  offer_type          = lookup(var.account[count.index], "offer_type")
  resource_group_name = data.azurerm_resource_group.this.name
  tags = lookup(var.account[count.index], "tags")
  minimal_tls_version = lookup(var.account[count.index], "minimal_tls_version")
  create_mode = lookup(var.account[count.index], "create_mode")
  default_identity_type = var.user_assigned_identity_name ? join("=", ["UserAssignedIdentity", data.azurerm_user_assigned_identity.this.id]) : lookup(var.account[count.index], "default_identity_type")
  kind = lookup(var.account[count.index], "kind")
  ip_range_filter = lookup(var.account[count.index], "ip_range_filter")
  free_tier_enabled = lookup(var.account[count.index], "free_tier_enabled")
  analytical_storage_enabled = lookup(var.account[count.index], "analytical_storage_enabled")
  automatic_failover_enabled = lookup(var.account[count.index], "automatic_failover_enabled")
  partition_merge_enabled = lookup(var.account[count.index], "partition_merge_enabled")
  burst_capacity_enabled = lookup(var.account[count.index], "burst_capacity_enabled")
  public_network_access_enabled = lookup(var.account[count.index], "public_network_access_enabled")
  is_virtual_network_filter_enabled = lookup(var.account[count.index], "is_virtual_network_filter_enabled")
  key_vault_key_id = var.key_vault_name ? data.azurerm_key_vault_key.this.id : element(module.keyvault.*.key_vault_key_id, lookup(var.account[count.index], "key_vault_key_id"))
  managed_hsm_key_id = var.managed_hardware_security_module_name ? data.azurerm_key_vault_managed_hardware_security_module_key.this.id : element(module.keyvault.*.managed_hsm_key_id, lookup(var.account[count.index], "managed_hsm_key_id"))
  multiple_write_locations_enabled = lookup(var.account[count.index], "multiple_write_locations_enabled")
  access_key_metadata_writes_enabled = lookup(var.account[count.index], "access_key_metadata_writes_enabled")
  mongo_server_version = lookup(var.account[count.index], "mongo_server_version")
  network_acl_bypass_for_azure_services = lookup(var.account[count.index], "network_acl_bypass_for_azure_services")
  network_acl_bypass_ids = []
  local_authentication_disabled = lookup(var.account[count.index], "local_authentication_disabled")

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
      consistency_level = lookup(consistency_policy.value, "consistency_level")
      max_interval_in_seconds = lookup(consistency_policy.value, "max_interval_in_seconds")
      max_staleness_prefix = lookup(consistency_policy.value, "max_staleness_prefix")
    }
  }

  dynamic "geo_location" {
    for_each = try(lookup(var.account[count.index], "geo_location") == null ? [] : ["geo_location"])
    content {
      failover_priority = lookup(geo_location.value, "failover_priority")
      location          = lookup(geo_location.value, "location")
      zone_redundant = lookup(geo_location.value, "zone_redundant")
    }
  }

  dynamic "virtual_network_rule" {
    for_each = try(lookup(var.account[count.index], "virtual_network_rule") == null ? [] : ["virtual_network_rule"])
    content {
      id = lookup(virtual_network_rule.value, "id")
      ignore_missing_vnet_service_endpoint = lookup(virtual_network_rule.value, "ignore_missing_vnet_service_endpoint")
    }
  }

  dynamic "backup" {
    for_each = try(lookup(var.account[count.index], "backup") == null ? [] : ["backup"])
    content {
      type = lookup(backup.value, "type")
      tier = lookup(backup.value, "tier")
      interval_in_minutes = lookup(backup.value, "interval_in_minutes")
      retention_in_hours = lookup(backup.value, "retention_in_hours")
      storage_redundancy = lookup(backup.value, "storage_redundancy")
    }
  }

  dynamic "cors_rule" {
    for_each = try(lookup(var.account[count.index], "cors_rule") == null ? [] : ["cors_rule"])
    content {
      allowed_headers = lookup(cors_rule.value, "allowed_headers")
      allowed_methods = lookup(cors_rule.value, "allowed_methods")
      allowed_origins = lookup(cors_rule.value, "allowed_origins")
      exposed_headers = lookup(cors_rule.value, "exposed_headers")
      max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds")
    }
  }

  dynamic "identity" {
    for_each = try(lookup(var.account[count.index], "identity") == null ? [] : ["identity"])
    content {
      type = lookup(identity.value, "type")
      identity_ids = [lookup(identity.value, "type") == "UserAssigned" ? data.azurerm_user_assigned_identity.this.id : lookup(identity.value, "identity_ids")]
    }
  }

  dynamic "restore" {
    for_each = try(lookup(var.account[count.index], "restore") == null ? [] : ["restore"])
    content {
      restore_timestamp_in_utc   = lookup(restore.value, "restore_timestamp_in_utc")
      source_cosmosdb_account_id = lookup(restore.value, "source_cosmosdb_account_id")
      tables_to_restore = lookup(restore.value, "tables_to_restore")

      dynamic "database" {
        for_each = try(lookup(restore.value, "database") == null ? [] : ["database"])
        content {
          name = lookup(database.value, "name")
          collection_names = [lookup(database.value, "collection_names")]
        }
      }

      dynamic "gremlin_database" {
        for_each = try(lookup(restore.value, "gremlin_database") == null ? [] : ["gremlin_database"])
        content {
          name = lookup(gremlin_database.value, "name")
          graph_names = [lookup(gremlin_database.value, "graph_names")]
        }
      }
    }
  }
}

resource "azurerm_cosmosdb_cassandra_cluster" "this" {
  count = length(var.cassandra_cluster)
  default_admin_password         = sensitive(lookup(var.cassandra_cluster[count.index], "default_admin_password"))
  delegated_management_subnet_id = data.azurerm_subnet.this.id
  location                       = data.azurerm_resource_group.this.location
  name                           = lookup(var.cassandra_cluster[count.index], "name")
  resource_group_name            = data.azurerm_resource_group.this.name
  authentication_method = lookup(var.cassandra_cluster[count.index], "authentication_method")
  external_gossip_certificate_pems = lookup(var.cassandra_cluster[count.index], "external_gossip_certificate_pems")
  external_seed_node_ip_addresses = lookup(var.cassandra_cluster[count.index], "external_seed_node_ip_addresses")
  hours_between_backups = lookup(var.cassandra_cluster[count.index], "hours_between_backups")
  repair_enabled = trulookup(var.cassandra_cluster[count.index], "repair_enabled")
  version = lookup(var.cassandra_cluster[count.index], "version")
  tags = lookup(var.cassandra_cluster[count.index], "tags")
  identity {
    type = "SystemAssigned"
  }
}