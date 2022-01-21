# TerraformTP
Terraform pratice


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.91.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.91.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service.app_service](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/app_service) | resource |
| [azurerm_app_service_plan.app_service](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/app_service_plan) | resource |
| [azurerm_mssql_database.mssql_database](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/mssql_database) | resource |
| [azurerm_mssql_database_extended_auditing_policy.db-policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/mssql_database_extended_auditing_policy) | resource |
| [azurerm_mssql_server.mssql_server](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/mssql_server) | resource |
| [azurerm_network_interface.i_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/network_interface) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.example](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/storage_container) | resource |
| [azurerm_subnet.example](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/subnet) | resource |
| [azurerm_traffic_manager_profile.traffic_manager](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/traffic_manager_profile) | resource |
| [azurerm_virtual_machine.example](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_machine_extension.example](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_network.v_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.91.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_app_service_name_vara"></a> [azure\_app\_service\_name\_vara](#input\_azure\_app\_service\_name\_vara) | n/a | `string` | `"AppService-TP"` | no |
| <a name="input_azure_hd_gateway_login"></a> [azure\_hd\_gateway\_login](#input\_azure\_hd\_gateway\_login) | n/a | `string` | `"acctestusrgw"` | no |
| <a name="input_azure_hd_gateway_pwd"></a> [azure\_hd\_gateway\_pwd](#input\_azure\_hd\_gateway\_pwd) | n/a | `string` | `"TerrAform123!"` | no |
| <a name="input_azure_hd_usr_login"></a> [azure\_hd\_usr\_login](#input\_azure\_hd\_usr\_login) | n/a | `string` | `"acctestusrvm"` | no |
| <a name="input_azure_hd_usr_pwd"></a> [azure\_hd\_usr\_pwd](#input\_azure\_hd\_usr\_pwd) | n/a | `string` | `"AccTestvdSC4daf986!"` | no |
| <a name="input_azure_location_vara"></a> [azure\_location\_vara](#input\_azure\_location\_vara) | n/a | `string` | `"West Europe"` | no |
| <a name="input_azure_mysql_login"></a> [azure\_mysql\_login](#input\_azure\_mysql\_login) | n/a | `string` | `"4dm1n157r470r"` | no |
| <a name="input_azure_mysql_pwd"></a> [azure\_mysql\_pwd](#input\_azure\_mysql\_pwd) | n/a | `string` | `"4-v3ry-53cr37-p455w0rd"` | no |
| <a name="input_azure_rg_name"></a> [azure\_rg\_name](#input\_azure\_rg\_name) | n/a | `string` | `"RG-TP"` | no |
| <a name="input_azure_storageaccount_name"></a> [azure\_storageaccount\_name](#input\_azure\_storageaccount\_name) | n/a | `string` | `"tpstorageaccount190122"` | no |
| <a name="input_azure_storageaccount_replication"></a> [azure\_storageaccount\_replication](#input\_azure\_storageaccount\_replication) | n/a | `string` | `"LRS"` | no |
| <a name="input_azure_storageaccount_tier"></a> [azure\_storageaccount\_tier](#input\_azure\_storageaccount\_tier) | n/a | `string` | `"Standard"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->