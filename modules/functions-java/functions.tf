resource "azurerm_app_service_plan" "functions_java" {
  name                = "${var.prefix}-service-plan"
  resource_group_name = azurerm_resource_group.functions
  location            = var.region
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = locals.default_tag
}

resource "azurerm_function_app" "functions_java" {
  name                      = "${var.prefix}-functions"
  resource_group_name       = azurerm_resource_group.functions.name
  location                  = var.region
  app_service_plan_id       = azurerm_app_service_plan.functions.id
  storage_connection_string = azurerm_storage_account.functions.primary_connection_string
  version                   = "~4"

  app_settings {
    AppInsights_InstrumentationKey = azurerm_application_insights.functions.instrumentation_key
  }

  site_config {
    java_version = 11
  }

  identity {
    type = "SystemAssigned"
  }

  tags = locals.default_tag
}

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "functions_java" {
  name               = azurerm_function_app.functions.name
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = "${data.azurerm_subscription.subscription.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azurerm_function_app.functions.identity[0]["principal_id"]
}
