variable "azure_location_vara" {
  type    = string
  default = "West Europe"
}

variable "azure_app_service_name_vara" {
  type    = string
  default = "AppService-TP"
}

variable "azure_rg_name" {
  type    = string
  default = "RG-TP"
}

variable "azure_storageaccount_name" {
  type    = string
  default = "tpstorageaccount190122"
}

variable "azure_storageaccount_tier" {
  type    = string
  default = "Standard"
}

variable "azure_storageaccount_replication" {
  type    = string
  default = "LRS"
}

variable "azure_mysql_login" {
  type    = string
  default = "4dm1n157r470r"
}

variable "azure_mysql_pwd" {
  type    = string
  default = "4-v3ry-53cr37-p455w0rd"
}

variable "azure_hd_gateway_login" {
  type    = string
  default = "acctestusrgw"
}

variable "azure_hd_gateway_pwd" {
  type    = string
  default = "TerrAform123!"
}

variable "azure_hd_usr_login" {
  type    = string
  default = "acctestusrvm"
}

variable "azure_hd_usr_pwd" {
  type    = string
  default = "AccTestvdSC4daf986!"
}