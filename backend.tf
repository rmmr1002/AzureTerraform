terraform {
   backend "azurerm" { 
      storage_account_name = "PREMADE STORAGE ACCOUNT"
      container_name       = "PREMADE CONTAINER NAME"
      key                  = "terraform.tfstate"
      environment          = "useast"
      access_key           = "PREMADE STORAGE ACCOUNT ACCESS KEY"
   }
} 
