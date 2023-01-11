terraform {
  backend "azurerm" {
    storage_account_name = "tfstate770384075"
    container_name       = "tfstatebackend"
    key                  = "Default"
    sas_token            = "?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-01-11T04:15:09Z&st=2023-01-10T20:15:09Z&spr=https&sig=HdMQR0Zqb%2F%2FTcYtbGAUlkosUClKLjcrPRitMGFgo1us%3D"
  }
}

resource "azurerm_resource_group" "onering_rg_dev" {
  name     = var.name
  location = "eastus"

  tags = {
    "owner" = "divine"
    "env"   = "dev"
  }
}