locals {
  devops_identities = [
    data.external.thisAccount.result.objectId
  ]
}

resource azurerm_key_vault_access_policy devops_kvap {
  certificate_permissions = ["backup", "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "restore", "setissuers", "update"]
  count                   = local.workspace["is_operating_env"] ? length(local.devops_identities) : 0
  key_permissions         = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
  key_vault_id            = module.kv.0.id
  object_id               = local.devops_identities[count.index]
  secret_permissions      = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
  storage_permissions     = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
  tenant_id               = data.azurerm_client_config.current.tenant_id
}

resource azurerm_key_vault_access_policy devops_kv2ap {
  certificate_permissions = ["backup", "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "restore", "setissuers", "update"]
  count                   = (local.workspace["is_operating_env"] && local.workspace["is_multi_region"]) ? length(local.devops_identities) : 0
  key_permissions         = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
  key_vault_id            = module.kv2.0.id
  object_id               = local.devops_identities[count.index]
  secret_permissions      = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
  storage_permissions     = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
  tenant_id               = data.azurerm_client_config.current.tenant_id
}