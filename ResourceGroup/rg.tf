# Create a resource group
resource "azurerm_resource_group" "rg-dev-network" {
  name     = var.rg_name
  location = var.rg_location
}