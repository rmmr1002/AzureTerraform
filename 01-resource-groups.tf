/*
  Filename: 01-resource-groups.tf
  Synopsis: Resource group that will contain all resources created in this module
  Description: NA
  Comments: NA
*/



### Creating resource group
resource "azurerm_resource_group" "terraform_resource_group" {
  name = "${var.resource_group_name}"
  location = "${var.location}"
   tags = {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ var.user }"
  }

}

