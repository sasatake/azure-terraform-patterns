resource "azurerm_service_plan" "functions_java" {
  name                = "${var.prefix}-service-plan"
  resource_group_name = azurerm_resource_group.functions_java.name
  location            = var.region
  os_type             = "Windows"
  sku_name            = "Y1"

  tags = local.default_tag
}

resource "azurerm_windows_function_app" "functions_java" {
  location                      = var.region
  name                          = "${var.prefix}-functions"
  resource_group_name           = azurerm_resource_group.functions_java.name
  service_plan_id               = azurerm_service_plan.functions_java.id
  functions_extension_version   = "~4"
  storage_account_name          = azurerm_storage_account.functions_java.name
  storage_uses_managed_identity = true

  app_settings = {
    AppInsights_InstrumentationKey = azurerm_application_insights.functions_java.instrumentation_key
    WEBSITE_RUN_FROM_PACKAGE       = 1
  }

  site_config {
    application_stack {
      java_version = 11
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.default_tag
}

resource "azurerm_role_assignment" "functions_java_storage_access" {
  scope                = azurerm_storage_account.functions_java.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.functions_java.identity.0.principal_id
}
