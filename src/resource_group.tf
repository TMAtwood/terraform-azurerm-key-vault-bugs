resource azurerm_resource_group rg {
  depends_on = [azurerm_resource_group.nw.0]
  name       = terraform.workspace
  location   = var.regions.0

  # Wait 60 seconds for resource group to come online
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

# Second region for high availability
resource azurerm_resource_group rg2 {
  count      = local.workspace["is_multi_region"] ? 1 : 0
  depends_on = [azurerm_resource_group.nw.0]
  name       = "${terraform.workspace}-${var.regions.1}"
  location   = var.regions.1

  # Wait 60 seconds for resource group to come online
  provisioner "local-exec" {
    command = "sleep 60"
  }
}