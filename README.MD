Project Example Module for Azure Cloud
=================================================

This space includes Terraform code to setup and configure an example project in the Azure Cloud.

Dependencies
------------
	
* Terraform 0.12 
* Azure Contributor level privileges
* Service Principal on Azure with Contributor role 


Project Example Module Details
------------------------------------

 The terraform name field is inhabited with default placeholders, which can later be customized by a user.
This terraform template creates 1 virtual network, 2 sub networks, 1 security group, 1 storage account, 1 storage container and 1 virtual machine. 
All resources are given an identcal group tag that allows them to be identifiable.

### Virtual Network

| Terraform Name              | Resource name                      | Comments                                                       |
| --------------------------- | ---------------------------------  | -------------------------------------------------------------- |
| YOURVNETNAME                | azurerm_virtual_network            | Virtual networks to contain all resources           |

### Subnets

| Terraform name     | Resource name      | CIDR            | Comments                       |
| ------------------ | ------------------ | --------------- | -------------------------------|
| YOURSUBNET1NAME    | azurerm_subnet     | 0.0.0.0/24   | Subnet for Virtual Network     |
| YOURSUBNET2NAME    | azurerm_subnet     | 0.0.0.0/24   | Subnet for Virtual Network     |

### Security Groups

| Terraform Name                | Resource name                      | Comments                                                       |
| ----------------------------- | ---------------------------------  | -------------------------------------------------------------- |
| network_security_group_egress | azurerm_network_security_group     | Allows all outbound traffic                    |
| network_security_group_ingress| azurerm_network_security_group     | Allows access to VNet         |
| network_security_group_vnet   | azurerm_network_security_group     | Allows traffic within the VNet                                 |


### Storage 

| Terraform Name              | Resource name                      | Comments                                                       |
| --------------------------- | ---------------------------------  | -------------------------------------------------------------- |
| yourstoragename             | azurerm_storage_account            | Storage account to manage block storage devices                |

### Virtual Machine 
| Terraform Name             | Resource name             | Size and OS                            | Public IP   | SSH username  | SSH password  | 
| -------------------------- | ------------------------- | -------------------------------------- | ----------- | ------------- | --------------| 
|   YOURVIRTUALMACHINENAME   | azurerm_virtual_machine   | Ubuntu 16.04 | true        | USERNAME      | PASSWORD123!  |

Setup of Project Virtual Network
======================================

When running on a new Azure account the following steps should be taken:

1. Clone repository
2. Use example module to create new project module; name project accordingly
3.  Create a file, terraform.tfvars and populate it. Note that you can use this file to give custom values to all the other variables in the 00-variables file as well
```
 subscription_id = ""
 client_id =""
 client_secret =""
 tenant_id =""
```
      
4. Create backend.tf file to store remote backend configurations
```
vi project##/backend.tf
```

5. Create a resource group using the azure cli by running the commands shown below.
```
RESOURCE_GROUP_NAME=YOUR RESOUCRE GROUP NAME
\# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus
```
6. Create a storage account using the Azure CLI
```
STORAGE_ACCOUNT_NAME=YOUR STORAGE ACCOUNT NAME
\# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
```
7. Get the account key for the storage account you just created using the Azure CLI
```
\# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)
```
8. Create a blob container in this storage account. This will serve as the remote backend.
```
\# Create blob container
CONTAINER_NAME=YOUR CONTAINER NAME
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY
```
9. Display the credentials you've created. Note the output, these variables will be used when populating backend.tf
```
echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY
```
10. Populate backend.tf file described in step 4 with the output from step 9. Note, to avoid stomping on others' state files, it is a good idea to have the directory where the `key` is being stored contain your userID in the name to assure that it is a unique location.
```
terraform {
    backend "azurerm" {
      storage_account_name = ""
      container_name       = ""
      key                  = "terraform.tfstate"
      environment          = "uswest"
      access_key           = ""
    }
}
```

11. Open 00-variables.tf file
```
vi project##/00-variables.tf
```

12. Modify all the "default" tags to change relevant parameters for the Virtual network. See the description tags in the same file for more information on what each variable is. 


Finishing Steps
---------------

1. Save locally and commit changes to git; create merge request and receive approval before proceeding
2. Navigate to the newly created project module directory
```
cd /project##
```

3. Initialize Terraform with specific backend pointing to backend.tfvars file
```
terraform init 
```

4. Review Terraform plan
```
terraform plan
```

5. Apply Terraform changes and confirm with `yes`
 ```
 terraform apply
 ```
 
Destroying the Virtual Network and resouces under it
----------------------------------------------------
 
 To destroy the entire VNet the following command is used:
 ```
 terraform destroy
 ```

Common Issue(s)
-------------- 
1. There are problems configuring the remote backend and changes to backend.tf or 00-variables.tf don't seem to reflect in error message If this occurs, try the following and run terraform init again:
```
cd project##/.terraform
rm terraform.tfstate
```
