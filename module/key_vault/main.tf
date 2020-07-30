data azurerm_client_config current {}

resource azurerm_key_vault kv {
  count                    = var.create_kv ? 1 : 0
  name                     = "${var.global_naming_domain}-kv${var.key_vault_name}-${terraform.workspace}"
  location                 = var.resource_group_location
  purge_protection_enabled = false
  resource_group_name      = var.resource_group_name
  sku_name                 = var.sku_name
  soft_delete_enabled      = false
  tags                     = var.tags
  tenant_id                = data.azurerm_client_config.current.tenant_id
}

# Key vault level only!
resource azurerm_storage_account kvaudit {
  account_kind             = "StorageV2"
  account_replication_type = var.is_prod_env ? "RAGZRS" : "LRS"
  account_tier             = "Standard"
  count                    = var.create_kv ? 1 : 0
  location                 = var.resource_group_location
  name                     = "${var.global_naming_domain}kvaudit${var.key_vault_name}${terraform.workspace}"
  resource_group_name      = var.resource_group_name
}

resource azurerm_log_analytics_workspace wsp {
  count               = var.create_kv ? 1 : 0
  location            = var.resource_group_location
  name                = "${var.global_naming_domain}-kvaudit${var.key_vault_name}-${terraform.workspace}"
  resource_group_name = var.resource_group_name
  retention_in_days   = var.is_prod_env ? 365 : 30
  sku                 = "PerGB2018"
}

resource azurerm_monitor_diagnostic_setting kvaudit {
  count                      = var.create_kv ? 1 : 0
  log_analytics_workspace_id = azurerm_log_analytics_workspace.wsp.0.id
  name                       = "${var.global_naming_domain}kvaudit${var.key_vault_name}${terraform.workspace}"
  storage_account_id         = azurerm_storage_account.kvaudit.0.id
  target_resource_id         = azurerm_key_vault.kv.0.id

  log {
    category = "AuditEvent"
    enabled  = true

    retention_policy {
      days    = var.is_prod_env ? 365 : 30
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      days    = var.is_prod_env ? 365 : 30
      enabled = true
    }
  }
}
