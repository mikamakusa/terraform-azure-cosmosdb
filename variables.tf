variable "resource_group_name" {
  type = string
}

variable "user_assigned_identity_name" {
  type    = string
  default = null
}

variable "key_vault_name" {
  type    = string
  default = null
}

variable "key_vault_key_name" {
  type    = string
  default = null
}

variable "managed_hardware_security_module_name" {
  type    = string
  default = null
}

variable "managed_hardware_security_module_key_name" {
  type    = string
  default = null
}

variable "key_vault" {
  type    = any
  default = []
}

variable "key_vault_key" {
  type    = any
  default = []
}

variable "managed_hardware_security_module" {
  type    = any
  default = []
}

variable "managed_hardware_security_module_key" {
  type    = any
  default = []
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "cosmosdb_account_name" {
  type    = string
  default = null
}

variable "account" {
  type = list(object({
    id                                    = any
    name                                  = string
    offer_type                            = string
    tags                                  = optional(map(string))
    minimal_tls_version                   = optional(string)
    create_mode                           = optional(string)
    default_identity_type                 = optional(string)
    kind                                  = optional(string)
    ip_range_filter                       = optional(list(string))
    free_tier_enabled                     = optional(bool)
    analytical_storage_enabled            = optional(bool)
    automatic_failover_enabled            = optional(bool)
    partition_merge_enabled               = optional(bool)
    burst_capacity_enabled                = optional(bool)
    public_network_access_enabled         = optional(bool)
    is_virtual_network_filter_enabled     = optional(bool)
    key_vault_key_id                      = optional(any)
    managed_hsm_key_id                    = optional(any)
    multiple_write_locations_enabled      = optional(bool)
    access_key_metadata_writes_enabled    = optional(bool)
    mongo_server_version                  = optional(string)
    network_acl_bypass_for_azure_services = optional(bool)
    network_acl_bypass_ids                = optional(list(any))
    local_authentication_disabled         = optional(bool)
    analytical_storage = optional(list(object({
      schema_type = string
    })), [])
    capabilities = optional(list(object({
      name = string
    })), [])
    capacity = optional(list(object({
      total_throughput_limit = number
    })), [])
    consistency_policy = optional(list(object({
      consistency_level       = string
      max_interval_in_seconds = optional(number)
      max_staleness_prefix    = optional(number)
    })), [])
    geo_location = optional(list(object({
      failover_priority = number
      location          = string
      zone_redundant    = optional(bool)
    })), [])
    virtual_network_rule = optional(list(object({
      id                                   = any
      ignore_missing_vnet_service_endpoint = optional(bool)
    })), [])
    backup = optional(list(object({
      type                = string
      tier                = string
      interval_in_minutes = optional(bool)
      retention_in_hours  = optional(bool)
      storage_redundancy  = optional(string)
    })), [])
    cors_rule = optional(list(object({
      allowed_headers    = list(any)
      allowed_methods    = list(any)
      allowed_origins    = list(any)
      exposed_headers    = list(any)
      max_age_in_seconds = optional(number)
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(any))
    })), [])
    restore = optional(list(object({
      restore_timestamp_in_utc   = string
      source_cosmosdb_account_id = any
      tables_to_restore          = optional(list(any))
      database = optional(list(object({
        name             = string
        collection_names = optional(list(any))
      })), [])
      gremlin_database = optional(list(object({
        name        = string
        graph_names = optional(list(any))
      })), [])
    })), [])
  }))
  default = []

  validation {
    condition     = length([for a in var.account : true if contains(["Tls", "Tls11", "Tls12"], a.minimal_tls_version)]) == length(var.account)
    error_message = "Possible values are: Tls, Tls11, and Tls12. Defaults to Tls12."
  }

  validation {
    condition     = length([for b in var.account : true if contains(["Default", "Restore"], b.create_mode)]) == length(var.account)
    error_message = "Possible values are Default and Restore."
  }

  validation {
    condition     = length([for c in var.account : true if contains(["FirstPartyIdentity", "SystemAssignedIdentity", "UserAssignedIdentity"], c.default_identity_type)]) == length(var.account)
    error_message = "Possible values are FirstPartyIdentity, SystemAssignedIdentity or UserAssignedIdentity."
  }

  validation {
    condition     = length([for d in var.account : true if contains(["GlobalDocumentDB", "MongoDB", "Parse"], d.kind)]) == length(var.account)
    error_message = "Possible values are GlobalDocumentDB, MongoDB and Parse."
  }

  validation {
    condition     = length([for e in var.account : true if contains(["7.0", "6.0", "5.0", "4.2", "4.0", "3.6", "3.2"], e.mongo_server_version)]) == length(var.account)
    error_message = "Possible values are 7.0, 6.0, 5.0, 4.2, 4.0, 3.6, and 3.2."
  }
}

variable "cassandra_cluster" {
  type = list(object({
    id                               = any
    default_admin_password           = string
    name                             = string
    authentication_method            = optional(string)
    external_gossip_certificate_pems = optional(list(string))
    external_seed_node_ip_addresses  = optional(list(string))
    hours_between_backups            = optional(number)
    repair_enabled                   = optional(bool)
    version                          = optional(string)
    tags                             = optional(map(string))
  }))
  default = []
}

variable "cassandra_datacenter" {
  type = list(object({
    id                              = any
    cassandra_cluster_id            = any
    name                            = string
    node_count                      = optional(number)
    backup_storage_customer_key_uri = optional(string)
    base64_encoded_yaml_fragment    = optional(string)
    disk_count                      = optional(number)
    disk_sku                        = optional(string)
    managed_disk_customer_key_uri   = optional(string)
    sku_name                        = optional(string)
    availability_zones_enabled      = optional(bool)
  }))
  default = []
}

variable "cassandra_keyspace" {
  type = list(object({
    id         = any
    account_id = any
    name       = string
    throughput = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
  }))
  default = []
}

variable "cassandra_table" {
  type = list(object({
    id                     = any
    cassandra_keyspace_id  = any
    name                   = string
    throughput             = optional(number)
    default_ttl            = optional(number)
    analytical_storage_ttl = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
    schema = optional(list(object({
      cluster_key = optional(list(object({
        name     = string
        order_by = string
      })), [])
      column = optional(list(object({
        name = string
        type = string
      })), [])
      partition_key = optional(list(object({
        name = string
      })), [])
    })), [])
  }))
  default = []
}

variable "gremlin_database" {
  type = list(object({
    id         = any
    account_id = any
    name       = string
    throughput = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
  }))
  default = []
}

variable "gremlin_graph" {
  type = list(object({
    id                     = any
    account_id             = any
    database_id            = any
    name                   = string
    partition_key_path     = string
    partition_key_version  = optional(number)
    throughput             = optional(number)
    analytical_storage_ttl = optional(number)
    default_ttl            = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
    index_policy = optional(list(object({
      indexing_mode  = string
      automatic      = optional(bool)
      included_paths = optional(list(string))
      excluded_paths = optional(list(string))
      composite_index = optional(list(object({
        index = optional(list(object({
          order = string
          path  = string
        })), [])
      })), [])
      spatial_index = optional(list(object({
        path = string
      })), [])
    })), [])
    conflict_resolution_policy = optional(list(object({
      mode                          = string
      conflict_resolution_path      = optional(string)
      conflict_resolution_procedure = optional(string)
    })), [])
    unique_key = optional(list(object({
      paths = list(string)
    })), [])
  }))
  default = []
}

variable "mongo_collection" {
  type = list(object({
    id                     = any
    account_id             = any
    database_id            = any
    name                   = string
    shard_key              = optional(string)
    analytical_storage_ttl = optional(number)
    default_ttl_seconds    = optional(number)
    throughput             = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
    index = optional(list(object({
      keys   = list(string)
      unique = optional(bool)
    })), [])
  }))
  default = []
}

variable "mongo_database" {
  type = list(object({
    id         = any
    account_id = any
    name       = string
    throughput = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
  }))
  default = []
}

variable "mongo_role_definition" {
  type = list(object({
    id                       = any
    cosmos_mongo_database_id = any
    role_name                = string
    inherited_role_names     = optional(list(string))
    privilege = optional(list(object({
      actions = list(any)
      resource = list(object({
        collection_name = optional(string)
        db_name         = optional(string)
      }))
    })), [])
  }))
  default = []
}

variable "mongo_user_definition" {
  type = list(object({
    id                       = any
    cosmos_mongo_database_id = any
    password                 = string
    username                 = string
    inherited_role_names     = optional(list(string))
  }))
  default = []
}

variable "postgresql_cluster" {
  type = list(object({
    id                                   = any
    name                                 = string
    node_count                           = number
    administrator_login_password         = optional(string)
    citus_version                        = optional(string)
    coordinator_public_ip_access_enabled = optional(bool)
    coordinator_server_edition           = optional(string)
    coordinator_storage_quota_in_mb      = optional(number)
    coordinator_vcore_count              = optional(number)
    ha_enabled                           = optional(bool)
    node_public_ip_access_enabled        = optional(bool)
    node_server_edition                  = optional(string)
    node_storage_quota_in_mb             = optional(number)
    node_vcores                          = optional(number)
    point_in_time_in_utc                 = optional(string)
    preferred_primary_zone               = optional(string)
    shards_on_coordinator_enabled        = optional(bool)
    source_location                      = optional(string)
    source_resource_id                   = optional(string)
    sql_version                          = optional(string)
    tags                                 = optional(map(string))
  }))
  default = []
}

variable "postgresql_coordinator_configuration" {
  type = list(object({
    id         = any
    cluster_id = any
    name       = string
    value      = string
  }))
  default = []
}

variable "postgresql_firewall_rule" {
  type = list(object({
    id               = any
    cluster_id       = any
    end_ip_address   = string
    name             = string
    start_ip_address = string
  }))
  default = []
}

variable "postgresql_node_configuration" {
  type = list(object({
    id         = any
    cluster_id = any
    name       = string
    value      = string
  }))
  default = []
}

variable "postgresql_role" {
  type = list(object({
    id         = any
    cluster_id = any
    name       = string
    password   = string
  }))
  default = []
}

variable "sql_container" {
  type = list(object({
    id                     = any
    account_id             = any
    database_id            = any
    name                   = string
    partition_key_paths    = list(string)
    partition_key_kind     = optional(string)
    partition_key_version  = optional(number)
    default_ttl            = optional(number)
    analytical_storage_ttl = optional(number)
    throughput             = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
    index_policy = optional(list(object({
      indexing_mode = string
      included_paths = optional(list(object({
        path = string
      })), [])
      composite_index = optional(list(object({
        index = optional(list(object({
          order = string
          path  = string
        })), [])
      })), [])
      spatial_index = optional(list(object({
        path = string
      })), [])
    })), [])
    conflict_resolution_policy = optional(list(object({
      mode                          = string
      conflict_resolution_path      = optional(string)
      conflict_resolution_procedure = optional(string)
    })), [])
    unique_key = optional(list(object({
      paths = list(string)
    })), [])
  }))
  default = []
}

variable "sql_database" {
  type = list(object({
    id         = any
    account_id = any
    name       = string
    throughput = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
  }))
  default = []
}

variable "sql_dedicated_gateway" {
  type = list(object({
    id                  = any
    cosmosdb_account_id = any
    instance_count      = number
    instance_size       = string
  }))
  default = []
}

variable "sql_function" {
  type = list(object({
    id           = any
    body         = string
    container_id = any
    name         = string
  }))
  default = []
}

variable "sql_role_assignment" {
  type = list(object({
    id                 = any
    account_id         = any
    role_definition_id = any
    scope              = string
    name               = optional(string)
  }))
  default = []
}

variable "sql_role_definition" {
  type = list(object({
    id                = any
    account_id        = any
    assignable_scopes = list(string)
    name              = string
    role_definition_id = optional(any)
    type = optional(string)
    permissions = list(object({
      data_actions = list(any)
    }))
  }))
  default = []
}

variable "sql_stored_procedure" {
  type = list(object({
    id           = any
    account_id   = any
    body         = string
    container_id = any
    database_id  = any
    name         = string
  }))
  default = []
}

variable "sql_trigger" {
  type = list(object({
    id           = any
    body         = string
    container_id = any
    name         = string
    operation    = string
    type         = string
  }))
  default = []
}

variable "table" {
  type = list(object({
    id         = any
    account_id = any
    name       = string
    throughput = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = optional(number)
    })), [])
  }))
  default = []
}
