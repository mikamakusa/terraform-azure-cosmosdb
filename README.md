## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ./modules/terraform-azure-keyvault | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_cassandra_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_cluster) | resource |
| [azurerm_cosmosdb_cassandra_datacenter.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_datacenter) | resource |
| [azurerm_cosmosdb_cassandra_keyspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_keyspace) | resource |
| [azurerm_cosmosdb_cassandra_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_table) | resource |
| [azurerm_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_key_vault_managed_hardware_security_module.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_managed_hardware_security_module) | data source |
| [azurerm_key_vault_managed_hardware_security_module_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_managed_hardware_security_module_key) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | <pre>list(object({<br/>    id                                    = any<br/>    name                                  = string<br/>    offer_type                            = string<br/>    tags                                  = optional(map(string))<br/>    minimal_tls_version                   = optional(string)<br/>    create_mode                           = optional(string)<br/>    default_identity_type                 = optional(string)<br/>    kind                                  = optional(string)<br/>    ip_range_filter                       = optional(list(string))<br/>    free_tier_enabled                     = optional(bool)<br/>    analytical_storage_enabled            = optional(bool)<br/>    automatic_failover_enabled            = optional(bool)<br/>    partition_merge_enabled               = optional(bool)<br/>    burst_capacity_enabled                = optional(bool)<br/>    public_network_access_enabled         = optional(bool)<br/>    is_virtual_network_filter_enabled     = optional(bool)<br/>    key_vault_key_id                      = optional(any)<br/>    managed_hsm_key_id                    = optional(any)<br/>    multiple_write_locations_enabled      = optional(bool)<br/>    access_key_metadata_writes_enabled    = optional(bool)<br/>    mongo_server_version                  = optional(string)<br/>    network_acl_bypass_for_azure_services = optional(bool)<br/>    network_acl_bypass_ids                = optional(list(any))<br/>    local_authentication_disabled         = optional(bool)<br/>    analytical_storage = optional(list(object({<br/>      schema_type = string<br/>    })), [])<br/>    capabilities = optional(list(object({<br/>      name = string<br/>    })), [])<br/>    capacity = optional(list(object({<br/>      total_throughput_limit = number<br/>    })), [])<br/>    consistency_policy = optional(list(object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = optional(number)<br/>      max_staleness_prefix    = optional(number)<br/>    })), [])<br/>    geo_location = optional(list(object({<br/>      failover_priority = number<br/>      location          = string<br/>      zone_redundant    = optional(bool)<br/>    })), [])<br/>    virtual_network_rule = optional(list(object({<br/>      id                                   = any<br/>      ignore_missing_vnet_service_endpoint = optional(bool)<br/>    })), [])<br/>    backup = optional(list(object({<br/>      type                = string<br/>      tier                = string<br/>      interval_in_minutes = optional(bool)<br/>      retention_in_hours  = optional(bool)<br/>      storage_redundancy  = optional(string)<br/>    })), [])<br/>    cors_rule = optional(list(object({<br/>      allowed_headers    = list(any)<br/>      allowed_methods    = list(any)<br/>      allowed_origins    = list(any)<br/>      exposed_headers    = list(any)<br/>      max_age_in_seconds = optional(number)<br/>    })), [])<br/>    identity = optional(list(object({<br/>      type         = string<br/>      identity_ids = optional(list(any))<br/>    })), [])<br/>    restore = optional(list(object({<br/>      restore_timestamp_in_utc   = string<br/>      source_cosmosdb_account_id = any<br/>      tables_to_restore          = optional(list(any))<br/>      database = optional(list(object({<br/>        name             = string<br/>        collection_names = optional(list(any))<br/>      })), [])<br/>      gremlin_database = optional(list(object({<br/>        name        = string<br/>        graph_names = optional(list(any))<br/>      })), [])<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_cassandra_cluster"></a> [cassandra\_cluster](#input\_cassandra\_cluster) | n/a | <pre>list(object({<br/>    id                               = any<br/>    default_admin_password           = string<br/>    name                             = string<br/>    authentication_method            = optional(string)<br/>    external_gossip_certificate_pems = optional(list(string))<br/>    external_seed_node_ip_addresses  = optional(list(string))<br/>    hours_between_backups            = optional(number)<br/>    repair_enabled                   = optional(bool)<br/>    version                          = optional(string)<br/>    tags                             = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_cassandra_datacenter"></a> [cassandra\_datacenter](#input\_cassandra\_datacenter) | n/a | <pre>list(object({<br/>    id                              = any<br/>    cassandra_cluster_id            = any<br/>    name                            = string<br/>    node_count                      = optional(number)<br/>    backup_storage_customer_key_uri = optional(string)<br/>    base64_encoded_yaml_fragment    = optional(string)<br/>    disk_count                      = optional(number)<br/>    disk_sku                        = optional(string)<br/>    managed_disk_customer_key_uri   = optional(string)<br/>    sku_name                        = optional(string)<br/>    availability_zones_enabled      = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_cassandra_keyspace"></a> [cassandra\_keyspace](#input\_cassandra\_keyspace) | n/a | <pre>list(object({<br/>    id         = any<br/>    account_id = any<br/>    name       = string<br/>    throughput = optional(number)<br/>    autoscale_settings = optional(list(object({<br/>      max_throughput = optional(number)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_cassandra_table"></a> [cassandra\_table](#input\_cassandra\_table) | n/a | <pre>list(object({<br/>    id                     = any<br/>    cassandra_keyspace_id  = any<br/>    name                   = string<br/>    throughput             = optional(number)<br/>    default_ttl            = optional(number)<br/>    analytical_storage_ttl = optional(number)<br/>    autoscale_settings = optional(list(object({<br/>      max_throughput = optional(number)<br/>    })), [])<br/>    schema = optional(list(object({<br/>      cluster_key = optional(list(object({<br/>        name     = string<br/>        order_by = string<br/>      })), [])<br/>      column = optional(list(object({<br/>        name = string<br/>        type = string<br/>      })), [])<br/>      partition_key = optional(list(object({<br/>        name = string<br/>      })), [])<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#input\_cosmosdb\_account\_name) | n/a | `string` | `null` | no |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | n/a | `any` | `[]` | no |
| <a name="input_key_vault_key"></a> [key\_vault\_key](#input\_key\_vault\_key) | n/a | `any` | `[]` | no |
| <a name="input_key_vault_key_name"></a> [key\_vault\_key\_name](#input\_key\_vault\_key\_name) | n/a | `string` | `null` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | n/a | `string` | `null` | no |
| <a name="input_managed_hardware_security_module"></a> [managed\_hardware\_security\_module](#input\_managed\_hardware\_security\_module) | n/a | `any` | `[]` | no |
| <a name="input_managed_hardware_security_module_key"></a> [managed\_hardware\_security\_module\_key](#input\_managed\_hardware\_security\_module\_key) | n/a | `any` | `[]` | no |
| <a name="input_managed_hardware_security_module_key_name"></a> [managed\_hardware\_security\_module\_key\_name](#input\_managed\_hardware\_security\_module\_key\_name) | n/a | `string` | `null` | no |
| <a name="input_managed_hardware_security_module_name"></a> [managed\_hardware\_security\_module\_name](#input\_managed\_hardware\_security\_module\_name) | n/a | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | n/a | `string` | n/a | yes |
| <a name="input_user_assigned_identity_name"></a> [user\_assigned\_identity\_name](#input\_user\_assigned\_identity\_name) | n/a | `string` | `null` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cassandra_cluster_id"></a> [cassandra\_cluster\_id](#output\_cassandra\_cluster\_id) | n/a |
| <a name="output_cassandra_cluster_name"></a> [cassandra\_cluster\_name](#output\_cassandra\_cluster\_name) | n/a |
| <a name="output_cassandra_datacenter_id"></a> [cassandra\_datacenter\_id](#output\_cassandra\_datacenter\_id) | n/a |
| <a name="output_cassandra_datacenter_name"></a> [cassandra\_datacenter\_name](#output\_cassandra\_datacenter\_name) | n/a |
| <a name="output_cassandra_keyspace_id"></a> [cassandra\_keyspace\_id](#output\_cassandra\_keyspace\_id) | n/a |
| <a name="output_cassandra_keyspace_name"></a> [cassandra\_keyspace\_name](#output\_cassandra\_keyspace\_name) | n/a |
| <a name="output_cassandra_table_id"></a> [cassandra\_table\_id](#output\_cassandra\_table\_id) | n/a |
| <a name="output_cassandra_table_name"></a> [cassandra\_table\_name](#output\_cassandra\_table\_name) | n/a |
| <a name="output_cosmosdb_account_id"></a> [cosmosdb\_account\_id](#output\_cosmosdb\_account\_id) | n/a |
| <a name="output_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#output\_cosmosdb\_account\_name) | n/a |
