data azurerm_client_config current {}

# Fetch current user info using the AZ cli
data external thisAccount {
  program = ["az", "ad", "signed-in-user", "show", "--query", "{displayName: displayName,objectId: objectId,objectType: objectType}"]
}

output account_id {
  value = data.azurerm_client_config.current.client_id
}

output object_id {
  value = data.azurerm_client_config.current.object_id
}

output signedInUser_objectId {
  value = data.external.thisAccount.result.objectId
}

output subscription_id {
  value = data.azurerm_client_config.current.subscription_id
}

output tenant_id {
  value = data.azurerm_client_config.current.client_id
}
