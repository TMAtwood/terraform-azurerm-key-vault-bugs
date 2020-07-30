variable regions {
  default     = ["eastus", "westus"]
  description = "Regions"
  type        = list(string)
}

variable subscription_id {
  description = "Subscription ID."
  type        = string
}

locals {
  env = {
    # Default to CCI
    default = {
      global_naming_domain = "tma"
      is_multi_region = false
      is_operating_env = false
      is_prod_env = false
      subscription_id = var.subscription_id
    }

    # DEVOPS
    devops = {
      global_naming_domain = "tma"
      is_operating_env = false
      is_prod_env = false
      subscription_id = var.subscription_id
    }

    # CCI
    cci = {
      global_naming_domain = "tma"
      is_multi_region = false
      is_operating_env = true
      is_prod_env = false
      subscription_id = var.subscription_id
    }

    # DEV
    dev = {
      global_naming_domain = "tma"
      is_multi_region = false
      is_operating_env = true
      is_prod_env = false
      subscription_id = var.subscription_id
    }

    # QA
    qa = {
      global_naming_domain = "tma"
      is_multi_region = false
      is_operating_env = true
      is_prod_env = false
      subscription_id = var.subscription_id
    }

    # UAT
    uat = {
      global_naming_domain = "tma"
      is_multi_region = false
      is_operating_env = true
      is_prod_env = false
      subscription_id = var.subscription_id
    }

    # PROD
    prod = {
      global_naming_domain = "tma"
      is_multi_region = false
      is_operating_env = true
      is_prod_env = true
      subscription_id = var.subscription_id
    }
  }

  workspace = merge(local.env["default"], local.env[terraform.workspace])
}
