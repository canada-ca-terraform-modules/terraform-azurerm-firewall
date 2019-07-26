# Microsoft Azure Firewall

## Introduction

This Terraform Module deploys a [Microsoft Azure Firewall](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2018-11-01/azurefirewalls) resource.

## Security Controls

The following security controls can be met through configuration of this template:

* AC-2, AC-3, AC-4, AC-5, AC-6, AC-8, AU-11, AU-12, AU-2, AU-3, AU-4, AU-8, AU-9, CM-3, CM-6, IA-2, IA-3, IA-5, SA-22, SC-10, SC-12, SC-13, SC-7, SC-8, SI-2, SI-4

## Dependancies

* [Resource Groups](https://github.com/canada-ca/accelerators_accelerateurs-azure/blob/master/Templates/arm/resourcegroups/latest/readme.md)
* [VNET-Subnet](https://github.com/canada-ca/accelerators_accelerateurs-azure/blob/master/Templates/arm/vnet-subnet/latest/readme.md)

## Usage

```terraform
terraform {
  required_version = ">= 0.12.1"
}

provider "azurerm" {
  version         = ">= 1.31.0"
  subscription_id = "2de839a0-37f9-4163-a32a-e1bdb8d6eb7e"
}

module "fortigateap" {
  #source = "github.com/canada-ca-terraform-modules/terraform-azurerm-fortigateap?ref=20190725.1"
  source = "./terraform-azurerm-firewall"

  location                = "canadacentral"
  fwprefix                = "${var.envprefix}-FW"
  vnet_name               = "${var.envprefix}-Core-NetCore-VNET"
  vnet_resourcegroup_name = "${var.envprefix}-Core-NetCore-RG"
}

resource "azurerm_firewall_nat_rule_collection" "test" {
  name                = "testcollection"
  azure_firewall_name = "${var.envprefix}-FW-firewall"
  resource_group_name = "${var.envprefix}-Core-NetCore-RG"
  priority            = 100
  action              = "Dnat"

  rule {
    name = "docker80"
    source_addresses = [ "*",  ]
    destination_addresses = [ "${module.fortigateap.fwpubip}", ]
    translated_address = "10.250.128.4"
    destination_ports = [ "80", ]
    translated_port    = "80"
    protocols = [ "TCP", ]
  }

  rule {
    name = "jumpboxRDS"
    source_addresses = [ "*",  ]
    destination_addresses = [ "${module.fortigateap.fwpubip}", ]
    translated_address = "100.96.120.4"
    destination_ports = [ "33890", ]
    translated_port    = "3389"
    protocols = [ "TCP", ]
  }
}

resource "azurerm_firewall_network_rule_collection" "test" {
  name                = "testcollection"
  azure_firewall_name = "${var.envprefix}-FW-firewall"
  resource_group_name = "${var.envprefix}-Core-NetCore-RG"
  priority            = 100
  action              = "Allow"

  rule {
    name = "all"
    source_addresses = ["*",]
    destination_ports = ["*",]
    destination_addresses = ["*",]
    protocols = [ "Any"]
  }
}
```

## Variable Values

To be documented

## History

| Date     | Release    | Change             |
| -------- | ---------- | ------------------ |
| 20190726 | 20190726.1 | 1st module version |
