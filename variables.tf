variable "resource_group_name" {
  type = string
}

variable "user_assigned_identity_name" {
  type = string
  default = null
}

variable "key_vault_name" {
  type = string
  default = null
}

variable "key_vault_key_name" {
  type = string
  default = null
}

variable "managed_hardware_security_module_name" {
  type = string
  default = null
}

variable "managed_hardware_security_module_key_name" {
  type = string
  default = null
}

variable "key_vault" {
  type = any
  default = []
}

variable "key_vault_key" {
  type = any
  default = []
}

variable "managed_hardware_security_module" {
  type = any
  default = []
}

variable "managed_hardware_security_module_key" {
  type = any
  default = []
}

variable "account" {
  type = list(object({
    id = any
    name                = string
    offer_type          = string
    tags = optional(map(string))
    minimal_tls_version = optional(string)
    create_mode = optional(string)
    kind = optional(string)
    ip_range_filter = optional(list(string))
    free_tier_enabled = optional(bool)
    analytical_storage_enabled = optional(bool)
    automatic_failover_enabled = optional(bool)
    partition_merge_enabled = optional(bool)
    burst_capacity_enabled = optional(bool)
    public_network_access_enabled = optional(bool)
    is_virtual_network_filter_enabled = optional(bool)
    key_vault_key_id = optional(any)
    managed_hsm_key_id = optional(any)
    multiple_write_locations_enabled = optional(bool)
    access_key_metadata_writes_enabled = optional(bool)
    mongo_server_version = optional(string)
    network_acl_bypass_for_azure_services = optional(bool)
    network_acl_bypass_ids = optional(list(any))
    local_authentication_disabled = optional(bool)
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
      consistency_level = string
      max_interval_in_seconds = optional(number)
      max_staleness_prefix = optional(number)
    })), [])
    geo_location = optional(list(object({
      failover_priority = number
      location          = string
      zone_redundant = optional(bool)
    })), [])
    virtual_network_rule = optional(list(object({
      id = any
      ignore_missing_vnet_service_endpoint = optional(bool)
    })), [])
    backup = optional(list(object({
      type = string
      tier = string
      interval_in_minutes = optional(bool)
      retention_in_hours = optional(bool)
      storage_redundancy = optional(string)
    })), [])
    cors_rule = optional(list(object({
      allowed_headers = list(any)
      allowed_methods = list(any)
      allowed_origins = list(any)
      exposed_headers = list(any)
      max_age_in_seconds = optional(number)
    })), [])
    identity = optional(list(object({
      type = string
      identity_ids = optional(list(any))
    })), [])
    restore = optional(list(object({
      restore_timestamp_in_utc   = string
      source_cosmosdb_account_id = any
      tables_to_restore = optional(list(any))
      database = optional(list(object({
        name = string
        collection_names = optional(list(any))
      })), [])
      gremlin_database = optional(list(object({
        name = string
        graph_names = optional(list(any))
      })), [])
    })), [])
  }))
  default = []
}