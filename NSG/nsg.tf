# Create NSG's
resource "azurerm_network_security_group" "nsg-snet-appsrv-001" {
  name                = var.nsg-snet-appsrv-001
  location            = var.rg_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "deny_all_outbound"
    priority                   = 400
    direction                  = "outbound"
    access                     = "deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_security_group" "nsg-snet-vm-001" {
  name                = var.nsg-snet-vm-001
  location            = var.rg_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "deny_all_outbound"
    priority                   = 300
    direction                  = "outbound"
    access                     = "deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "outbound-privateEndpoint-subnet"
    priority                   = 200
    direction                  = "outbound"
    access                     = "deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.1.41.64/27"
  }
  security_rule {
    name                       = "outbound-azuredns"
    priority                   = 100
    direction                  = "outbound"
    access                     = "deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "*"
    destination_address_prefix = "168.63.129.16"
  }

  tags = {
    environment = "dev"
  }
}

