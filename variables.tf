variable "azure_location_vara" {
  type = string
  default = "West Europe"
}

variable "azure_rg_name" {
  type = string
  default = "RG-TP"
}

variable "azure_storageaccount_name" {
  type = string
  default = "tp-storage-account"
}

variable "azure_storageaccount_tier" {
  type = string
  default = "Standard"
}

variable "azure_storageaccount_replication" {
  type = string
  default = "LRS"
}