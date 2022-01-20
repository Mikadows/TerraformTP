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

resource "azurerm_storage_container" "st_container" {
  name                  = "hdinsight"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_hdinsight_hadoop_cluster" "hadoop_cluster" {
  name                = "example-hdicluster-190122"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  cluster_version     = "3.6"
  tier                = "Standard"

  component_version {
    hadoop = "2.7"
  }

  gateway {
    username = var.azure_hd_gateway_login
    password = var.azure_hd_gateway_pwd
  }

  storage_account {
    storage_container_id = azurerm_storage_container.st_container.id
    storage_account_key  = azurerm_storage_account.storage_account.primary_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "Standard_D3_V2"
      username = var.azure_hd_usr_login
      password = var.azure_hd_usr_pwd
    }

    worker_node {
      vm_size               = "Standard_D4_V2"
      username              = var.azure_hd_usr_login
      password              = var.azure_hd_usr_pwd
      target_instance_count = 3
    }

    zookeeper_node {
      vm_size  = "Standard_D3_V2"
      username = var.azure_hd_usr_login
      password = var.azure_hd_usr_pwd
    }
  }
}