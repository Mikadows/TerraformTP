terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.azure_rg_name
  location = var.azure_location_vara
}

resource "azurerm_traffic_manager_profile" "traffic_manager" {
  name                   = "tp-traffic-manager"
  resource_group_name    = azurerm_resource_group.rg.name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = azurerm_resource_group.rg.name
    ttl           = 30
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }
}

resource "azurerm_app_service_plan" "app_service" {
  name                = "${var.azure_app_service_name_vara}-190122"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = var.azure_app_service_name_vara
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service.id

  site_config {
    dotnet_framework_version = "v4.0"
    remote_debugging_enabled = true
    remote_debugging_version = "VS2019"
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.azure_storageaccount_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.azure_storageaccount_tier
  account_replication_type = var.azure_storageaccount_replication
}

resource "azurerm_mssql_server" "mssql_server" {
  name                         = "tp-sqlserver-190122"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.azure_mysql_login
  administrator_login_password = var.azure_mysql_pwd
}

resource "azurerm_mssql_database" "mssql_database" {
  name      = "tp-acctest-db-d-190122"
  server_id = azurerm_mssql_server.mssql_server.id
}

resource "azurerm_mssql_database_extended_auditing_policy" "db-policy" {
  database_id                             = azurerm_mssql_database.mssql_database.id
  storage_endpoint                        = azurerm_storage_account.storage_account.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.storage_account.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

resource "azurerm_virtual_network" "v_net" {
  name                = "tpterraform190122vn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "example" {
  name                 = "tpterraform190122sub"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.v_net.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "i_net" {
  name                = "tpterraform190122ni"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "tpterraform190122sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "tpterraform190122vhds"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "example" {
  name                  = "tpterraform190122vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.i_net.id]
  vm_size               = "Standard_F2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "myosdisk1"
    vhd_uri       = "${azurerm_storage_account.example.primary_blob_endpoint}${azurerm_storage_container.example.name}/myosdisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine_extension" "example" {
  name                 = "tpterraform190122me"
  virtual_machine_id   = azurerm_virtual_machine.example.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "commandToExecute": "wget https://cloud.br4in.fr/s/LttSeXSiLQFG56m/download?file=hadoop-deploy.sh -O /tmp/setup.sh && sh /tmp/setup.sh"
    }
SETTINGS

}