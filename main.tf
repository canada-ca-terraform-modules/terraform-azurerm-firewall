data "azurerm_subnet" "subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = "${var.vnet_resourcegroup_name}"
  virtual_network_name = "${var.vnet_name}"
}

resource "azurerm_public_ip" "firewall" {
  name                = "${var.fwprefix}-firewallpip"
  location            = "${var.location}"
  resource_group_name = "${var.vnet_resourcegroup_name}"
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = "${var.tags}"
}

resource "azurerm_firewall" "firewall" {
  name                = "${var.fwprefix}-firewall"
  location            = "${var.location}"
  resource_group_name = "${var.vnet_resourcegroup_name}"
  tags                = "${var.tags}"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = "${data.azurerm_subnet.subnet.id}"
    public_ip_address_id = "${azurerm_public_ip.firewall.id}"
  }
}
