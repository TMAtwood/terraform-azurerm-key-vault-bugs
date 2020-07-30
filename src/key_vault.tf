module kv {
  source = "../module/key_vault"

  create_kv            = local.create_network
  global_naming_domain = local.workspace["global_naming_domain"]

  ip_rules = [
    var.ipaddress_tom_home_office
  ]

  is_prod_env             = local.workspace["is_prod_env"]
  key_vault_name          = ""
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  subscription_id         = local.workspace["subscription_id"]
}

module kv2 {
  source = "../module/key_vault"

  create_kv            = (local.workspace["is_operating_env"] && local.workspace["is_multi_region"])
  global_naming_domain = local.workspace["global_naming_domain"]

  ip_rules = [
    var.ipaddress_tom_home_office
  ]

  is_prod_env             = local.workspace["is_prod_env"]
  key_vault_name          = "westus"
  resource_group_location = local.workspace["is_multi_region"] ? azurerm_resource_group.rg2.0.location : ""
  resource_group_name     = local.workspace["is_multi_region"] ? azurerm_resource_group.rg2.0.name : ""
  subscription_id         = local.workspace["subscription_id"]
}
