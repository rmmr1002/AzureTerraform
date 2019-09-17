/*
  Filename: 05-ipaddress.tf
  Synopsis: Creates the public IP Address
  Description: N/A
  Comments: N/A
*/

### Public IP block
resource "azurerm_public_ip" "public_ip" {
  name = "${var.public_ip_name}"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  public_ip_address_allocation = "static"
   tags = {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var.user }"
  }
}


