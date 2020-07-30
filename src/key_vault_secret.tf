resource azurerm_key_vault_secret test {
  count        = local.workspace["is_operating_env"] ? 1 : 0
  key_vault_id = module.kv.0.id
  name         = "testkey"
  value        = "testvalue"

  tags = {
    environment          = terraform.workspace
    managed-by-terraform = true
  }
}
