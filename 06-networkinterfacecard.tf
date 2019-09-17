/*
  Filename: 06-ipaddress.tf
  Synopsis: Creates the Network Interface
  Description: N/A
  Comments: N/A
*/


### Network Interface blocks, each Network Interface Card corresponds to one security group


resource "azurerm_network_interface" "public_network_interface_card1" {
  name       = "${var.network_interface_card_name}1"
  location       = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  network_security_group_id = "${azurerm_network_security_group.network_security_group_web.id}"
  ip_configuration {
    name = "Virtual_Machine_Private_IP_Configuration"
    subnet_id = "${azurerm_subnet.subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id= "${azurerm_public_ip.public_ip.id}"
  }
   tags = {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var.user }"
  }

}

resource "azurerm_network_interface" "public_network_interface_card2" {
  name       = "${var.network_interface_card_name}2"
  location       = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  network_security_group_id = "${azurerm_network_security_group.network_security_group_egress.id}"
  ip_configuration {
    name = "Virtual_Machine_Private_IP_Configuration"
    subnet_id = "${azurerm_subnet.subnet_1.id}"
    private_ip_address_allocation = "dynamic"
  }
   tags = {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var.user }"
  }

}


resource "azurerm_network_interface" "public_network_interface_card3" {
  name       = "${var.network_interface_card_name}3"
  location       = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  network_security_group_id = "${azurerm_network_security_group.network_security_group_vnet.id}"
  ip_configuration {
    name = "Virtual_Machine_Private_IP_Configuration"
    subnet_id = "${azurerm_subnet.subnet_1.id}"
    private_ip_address_allocation = "dynamic"
  }
   tags = {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var._user }"
  }

}

