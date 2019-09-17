/*
  Filename: 00-variables.tf
  Synopsis: Terraform input variables and configuration to use azure
  Description: Variables that will be used for creation of a new Vnet and related resources
  Comments: Customize the default fields to necessary values
*/

### Variables for authentication
variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}


variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}


variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}


variable "tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}


### Variables for global config
variable "location" {
  description = "The default Azure region for the resource provisioning"
  default = "useast"
}


variable "resource_group_name" {
  description = "Resource group name that will contain various resources"
  default = "YOURRESOUCEGROUP"
}


variable "user" {
  description =  "user tag to identify similar resources "
  default = "YOURDEFAULTUSER"
}


### Variables for networking
variable "vnet_name" {
  description = "Name for Virtual network"
  default = "YOURVNETNAME"
}


variable "subnet1_name" {
  description = "Name for first subnetwork"
  default = "YOURSUBNET1NAME"
}


variable "subnet2_name" {
  description = "Name for second subnetwork"
  default = "YOURSUBNET2NAME"
}


variable "vnet_cidr" {
  description = "CIDR block for Virtual Network"
  default = "0.0.0.0/16"
}


variable "subnet1_cidr" {
  description = "CIDR block for Subnet within a Virtual Network"
  default = "0.0.0.0/24"
}


variable "subnet2_cidr" {
  description = "CIDR block for Subnet within a Virtual Network"
  default = "0.0.0.0/24"
}


### Variables for Storage
variable "storage_account_name" {
  description = "Name for storage account"
  default = "yourstoragename"
}


variable "storage_name" {
  description = "Name for storage blob"
  default = "yourblobname"
}


### Variables for IP and Network Interace Card
variable "public_ip_name" {
  description = "Name for public IP"
  default = "YOURPUBLICIPNAME"
}


variable "network_interface_card_name" {
  description = "name for public Network Interface Card"
  default = "YOURNETWORKINTERFACECARDNAME"
}


### Variables for Virtual Machine
variable "virtual_machine_name" {
  description = "name for Virtual Machine"
  default = "YOURVIRTUALMACHINENAME"
}


variable "virtual_machine_size" {
  description = "size type for Virtual Machine"
  default = "STANDARD_B1S"
}


variable "virtual_machine_username" {
  description = "Enter admin username to SSH into Linux VM"
  default = "USERNAME"
}


variable "virtual_machine_password" {
  description = "Enter admin password to SSH into VM"
  default = "TACOSFORLIFE!"
}
