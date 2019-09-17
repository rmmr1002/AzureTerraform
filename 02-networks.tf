/*
  Filename: 02-networks.tf
  Synopsis: Creates the Virtual Network and two subnets under it
  Description: N/A
  Comments: Also creates the resource group for all resouces.
*/


### Creating Vnet
resource "azurerm_virtual_network" "virtual_network" {
  name = "${var.vnet_name}"
  address_space = ["${var.vnet_cidr}"] 
  location = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_resource_group.name}"
  tags = {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var.user }"
  }
}


### Creating first subnet
resource "azurerm_subnet" "subnet_1" {
  name = "${var.subnet1_name}"
  address_prefix = "${var.subnet1_cidr}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
}


### Creating second subnet
resource "azurerm_subnet" "subnet_2" {
  name = "${var.subnet2_name}"
  address_prefix = "${var.subnet2_cidr}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
}
