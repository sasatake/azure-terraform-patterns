resource "azurerm_service_plan" "functions_java" {
  name                = "${var.prefix}-service-plan"
  resource_group_name = azurerm_resource_group.functions_java.name
  location            = var.region
  os_type             = "Linux"
  sku_name            = "Y1"

  tags = local.default_tag
}

resource "azurerm_linux_function_app" "functions_java" {
  name                        = "${var.prefix}-functions"
  resource_group_name         = azurerm_resource_group.functions_java.name
  location                    = var.region
  service_plan_id             = azurerm_service_plan.functions_java.id
  storage_account_name        = azurerm_storage_account.functions_java.name
  functions_extension_version = "~4"

  app_settings = {
    AppInsights_InstrumentationKey = azurerm_application_insights.functions_java.instrumentation_key
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

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "functions_java" {
  name               = azurerm_linux_function_app.functions_java.name
  scope              = data.azurerm_subscription.current.subscription_id
  role_definition_id = "${data.azurerm_subscription.current.subscription_id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azurerm_linux_function_app.functions_java.identity[0].principal_id
}
