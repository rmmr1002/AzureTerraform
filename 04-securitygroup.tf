/*
  Filename: 04-security-group.tf
  Synopsis: Creates the security group to be associated with the network
  Description: The security group allows ssh and http connections 
  Comments: N/A
*/

### Security group for all egress
resource "azurerm_network_security_group" "network_security_group_egress" {
  name = "${var.vnet_name}-egress-security_group"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  security_rule {
    name = "EgressRule"
    priority = 100
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "0.0.0.0/
    destination_address_prefix = "*"
    description = "Allow all outbound traffic"
  }
 tags = {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var.user }"
  }

}


### Security group for ingress from  networks
resource "azurerm_network_security_group" "network_security_group_web" {
  name = "${var.vnet_name}-access-security-group"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  security_rule {
    name = "AllowSpecificAccess"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "22"
    destination_port_range = "22"
    source_address_prefix = "1.2.3.4/32"
    destination_address_prefix = "*"
    description = "Ingress to SSH"
  }
  security_rule {
    name = "AllowSpecificAccess"
    priority= 200
    direction= "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "22"
    destination_port_range = "22"
    source_address_prefix = "2.4.6.8/32"
    destination_address_prefix = "*"
    description = "Ingress to SSH"
  }
  security_rule {
    name = "AllowRDP"
    priority= 300
    direction= "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "3389"
    destination_port_range = "3389"
    source_address_prefix = "3.6.9.12/32"
    destination_address_prefix = "*"
    description = "Ingress to RDP"
  }
  security_rule {
    name = "AllowRDP"
    priority= 400
    direction= "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "3389"
    destination_port_range = "3389"
    source_address_prefix = "4.8.12.20/32"
    destination_address_prefix = "*"
    description = "Ingress to RDP"
  }
  tags =  {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var.user }"
  }
}


### Security group for all intra vnet communication
resource "azurerm_network_security_group" "network_security_group_vnet" {
  name = "${var.vnet_name}-vnet-security_group"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  security_rule {
    name = "VNetRuleOutbound"
    priority = 100
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "${var.vnet_cidr}"
    destination_address_prefix = "${var.vnet_cidr}"
    description = "Allow all intra VPC traffic"
  }
  security_rule {
    name = "VNetRuleInbound"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "${var.vnet_cidr}"
    destination_address_prefix = "${var.vnet_cidr}"
    description = "Allow all intra VPC traffic"
  }

   tags =  {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var.user }"
  }

}

