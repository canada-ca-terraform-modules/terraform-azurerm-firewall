output "fwpubip" {
  value = "${azurerm_public_ip.firewall.ip_address}"
}
