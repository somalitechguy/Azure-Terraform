resource "azurerm_virtual_network" "vnet-ss-dev-uks-001" {
  name                = var.vnetdev_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = var.vnetdev_iprange

}

# this will create 2 subnets
resource "azurerm_subnet" "snets" {
  count                = length(var.snet_names)
  name                 = var.snet_names[count.index]
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet-ss-dev-uks-001.name
  address_prefixes     = [element(var.snet_link_address,count.index)]
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.snets[1].id
  network_security_group_id = var.network_security_group_id
}

