output "cluster_name" {
    value = azurerm_kubernetes_cluster.aks_test.name
}

output "kube_config" {
    value = azurerm_kubernetes_cluster.aks_test.kube_config_raw
}
