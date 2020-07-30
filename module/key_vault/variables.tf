# Allows for the azure AD tenant id to be overriden
variable azure_active_directory_id {
  description = "The Directory ID of your Azure Active Directory, viewable in Properties on the Azure Portal. Defaults to the current Az CLI User's Account"
  default     = "azureactivedirectoryiddefault"
  type        = string
}

variable create_kv {
  default     = false
  description = "Create key vault?"
  type        = bool
}

variable global_naming_domain {
  description = "Global naming domain."
  type        = string
}

variable ip_rules {
  description = "List of IP addresses to allow."
  type        = list(string)
}

variable is_prod_env {
  default     = false
  description = "Is production environment?"
  type        = bool
}

variable key_vault_name {
  description = "The key vault name (e.g., entitlements, etc.)."
  type        = string
}

variable resource_group_location {
  default     = "East US"
  description = "The resource group location for the SQL server instance and elastic pool."
  type        = string
}

variable resource_group_name {
  default     = "defaults" # Default workspace
  description = "The resource group name."
  type        = string
}

variable sku_name {
  default     = "standard"
  description = "Key vault sku name."
  type        = string
}

variable subscription_id {
  description = "The subscription ID."
  type        = string
}

variable tags {
  default     = {}
  description = "A map of tags to add to all resources."
  type        = map(string)
}
