resource "azurerm_kubernetes_cluster" "aks_test" {
  name                = "aks-test-cluster"
  location            = azurerm_resource_group.aks_test.location
  resource_group_name = azurerm_resource_group.aks_test.name
  node_resource_group = "aks-test-node-rg"
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
  
  tags = {
    createdBy = "Terraform"
    module = "aks"
  }
}