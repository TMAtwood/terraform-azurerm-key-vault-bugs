# Configure the Microsoft Azure Active Directory Provider
provider azuread {
  version = "~>0.11.0"
}

provider azurerm {
  subscription_id = local.workspace["subscription_id"]
  version         = "~>2.20.0"

  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
