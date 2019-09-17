/*
  Filename: 07-virtualmachine.tf
  Synopsis: Creates the Virtual Machine
  Description: 
  Comments: Use the vm_name and vm_size variables to specify name and size. Default is Standard DS1_v2
*/


### Image resouce for OS for Virtual Machine. 
# NOTE: Change this to customize the OS for the Virtual Machine based on existing Images.
data "azurerm_image" "virtual_machine-custom" { 
  name                = "Ubuntu-16.04"
  resource_group_name = "custom-resource-group"
}

### Configure the Virtual Machine
resource "azurerm_virtual_machine" "virtual_machine-custom" {
  name                  = "${var.virtual_machine_name}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_resource_group.name}"
  network_interface_ids = ["${azurerm_network_interface.public_network_interface_card1.id}"]  
  vm_size               = "${var.virtual_machine_size}"

# NOTE: This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "${data.azurerm_image.virtual_machine-custom.id}"
  }

  storage_os_disk {
    name          = "osdisk-1"
    caching       = "ReadWrite"
# NOTE: This uri is from the Azure console and is the url for the -RHEL-7,6-Base-V1.0
    create_option = "FromImage"
  }
  os_profile {
    computer_name  = "linuxhost"
    admin_username = "${var.virtual_machine_username}"
    admin_password = "${var.virtual_machine_password}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
# NOTE: A maximum of 15 tags can be associated
   tags = {
       Name = "${ var.vnet_name }-RHEL7_6-Jumpbox-1"
        Managed-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        User = "${ var.user }"
  }    
}
