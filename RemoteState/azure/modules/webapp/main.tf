terraform {
  backend "azurerm" {
    storage_account_name = "tfstate770384075"
    container_name       = "tfstatebackend"
    key                  = "Default"
    sas_token            = "?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-01-11T04:15:09Z&st=2023-01-10T20:15:09Z&spr=https&sig=HdMQR0Zqb%2F%2FTcYtbGAUlkosUClKLjcrPRitMGFgo1us%3D"
  }
}

resource "azurerm_service_plan" "onering_ap_dev" {
  name                = "oneringwebplansetup"
  location            = "eastus"
  resource_group_name = "onering_nextgen_rsc" 
  os_type             = "Windows"
  sku_name            = "B1"

  depends_on = [
    azurerm_resource_group.onering_rg_dev
  ]

 
}

resource "azurerm_windows_web_app" "onering_wa_dev" {
  name                = "oneringwebapp"
  location            = "eastus"
  resource_group_name = "webservices_rsc"
  service_plan_id     = azurerm_service_plan.onering_ap_dev.id
  https_only          = true

  site_config {
    always_on      = true
  }
  
  
  depends_on = [
    azurerm_windows_web_app.onering_wa_dev
  ]

#   app_settings = {
#     "SOME_KEY" = "some-value"
#   }

#   connection_string {
#     name  = "Database"
#     type  = "SQLServer"
#     value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
#   }
}