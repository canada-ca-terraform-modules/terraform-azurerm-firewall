variable "location" {
  description = "Location of the network"
  default     = "canadacentral"
}

variable "tags" {
  default = {
    "Organizations"     = "PwP0-CCC-E&O"
    "DeploymentVersion" = "2018-12-14-01"
    "Classification"    = "Unclassified"
    "Enviroment"        = "Sandbox"
    "CostCenter"        = "PwP0-EA"
    "Owner"             = "cloudteam@tpsgc-pwgsc.gc.ca"
  }
}

variable "fwprefix" {
  default = "FW"
}
variable "vnet_name" {
  default = "test-NetCore-VNET"
}
variable "vnet_resourcegroup_name" {
  default = "test-NetCore-RG"
}
