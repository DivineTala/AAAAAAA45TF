terraform {
  backend "azurerm" {
    storage_account_name = "tfstate770384075"
    container_name       = "tfstatebackend"
    key                  = "Default"
    sas_token            = "?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-01-11T04:15:09Z&st=2023-01-10T20:15:09Z&spr=https&sig=HdMQR0Zqb%2F%2FTcYtbGAUlkosUClKLjcrPRitMGFgo1us%3D"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}



resource "azurerm_resource_group" "dev" {
  name     = "onering_nextgen_rsc"
  location = "eastus"
  tags = {
    "owner" = "divine"
    "env"   = "dev"
  }

}

resource "azurerm_storage_account" "dev" {
  name                     = "oneringstore"
  resource_group_name      = "onering_nextgen_rsc"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.dev
  ]
}

resource "azurerm_storage_container" "dev" {
  name                  = "oneringbox"
  storage_account_name  = "oneringstore"
  container_access_type = "blob"

  depends_on = [
    azurerm_storage_account.dev
  ]
  
}

resource "azurerm_storage_blob" "dev" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = "oneringstore"
  storage_container_name = "oneringbox"
  type                   = "Block"
  source                 = "C:/Users/win/My-Azure_Webapp/sample.html"

  depends_on = [
    azurerm_storage_container.dev
  ]
}
