/*
  Filename: 03-storage.tf
  Synopsis: Creates the storage account and container
  Description: N/A
  Comments: N/A
*/


### Creating storage account
resource "azurerm_storage_account" "storage" {
  name = "${var.storage_account_name}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  location = "${var.location}"
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags =  {
      Managed-By = "Terraform"
      ProvisionDate = "${ timestamp() }"
      User = "${ varuser }"
  }
}


### Creating storage container 
resource "azurerm_storage_container" "container" {
  name = "${var.storage_name}"
  resource_group_name = "${azurerm_resource_group.terraform_resource_group.name}"
  storage_account_name = "${azurerm_storage_account.storage.name}"
  # NOTE: This field can be private, blob or container
  container_access_type = "private"
}
