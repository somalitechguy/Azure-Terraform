terraform {
  required_version = ">=0.13"
  backend "azurerm" {
    resource_group_name  = "tstate"
    storage_account_name = "tfstatefaisal"
    container_name       = "tfstate"
    key                  = "tf.tfstate"
    
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    # version = "=2.91.0"
    features {
      
    }
}

data "azurerm_client_config" "current" {}

module "ResourceGroup" {
  source     = "./ResourceGroup"
  rg_location   = var.rg_location
  rg_name    = var.rg_name
}

module "NSG" {
  source = "./NSG"
  rg_name = module.ResourceGroup.rg_name_output
  rg_location = module.ResourceGroup.rg_location_output
  nsg-snet-appsrv-001 = var.nsg-snet-appsrv-001
  nsg-snet-vm-001 = var.nsg-snet-vm-001
}

module "vnet_dev" {
  source = "./vNet"
  rg_name = module.ResourceGroup.rg_name_output
  rg_location = module.ResourceGroup.rg_location_output
  vnetdev_name = "vnet-ss-dev-uks-001"
  snet_names = ["snet-plink-dev-uks-001", "snet-ibis-appsrv-api-dev-uks-001"]
  vnetdev_iprange = ["10.1.40.0/22"]
  snet_link_address = ["10.1.41.64/27", "10.1.41.0/27"]
  network_security_group_id = module.NSG.nsg_appsrv_id_output
}


module "kv" {
  source = "./keyvault"
  rg_name = module.ResourceGroup.rg_name_output
  rg_location = module.ResourceGroup.rg_location_output
  kv_name = "faisalabdi9911"
}