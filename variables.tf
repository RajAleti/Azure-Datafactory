# Global settings
variable "global_settings" {
  description = "Global settings object for the current deployment."
  default = {
    passthrough    = false
    random_length  = 4
    default_region = "region1"
    regions = {
      region1 = "southeastasia"
      region2 = "eastasia"
    }
  }
}

variable "client_config" {
  default = {}
}

variable "df_name" {
  default = {}
}

   
variable "tenant_id" {
  description = "Azure AD Tenant ID for the current deployment."
  type        = string
  default     = null
}

variable "current_landingzone_key" {
  description = "Key for the current landing zones where the deployment is executed. Used in the context of landing zone deployment."
  default     = "local"
  type        = string
}


variable "environment" {
  description = "Name of the CAF environment."
  type        = string
  default     = "cdt"
}

variable "logged_user_objectId" {
  description = "Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode."
  type        = string
  default     = null
}
variable "logged_aad_app_objectId" {
  description = "Used to set access policies based on the value 'logged_in_aad_app'"
  type        = string
  default     = null
}

variable "use_msi" {
  description = "Deployment using an MSI for authentication."
  default     = false
  type        = bool
}

variable "tags" {
  description = "Tags to be used for this resource deployment."
  type        = map(any)
  default     = null
}

variable "resource_groups" {
  description = "Configuration object - Resource groups."
  default     = {}
}

variable "subscriptions" {
  description = "Configuration object - Subscriptions resources."
  default     = {}
}

variable "connectivity_subscription_id" {
  description = "Connectivity subscription id"
  default     = null
}

variable "connectivity_tenant_id" {
  description = "Connectivity tenant id"
  default     = null
}

variable "subscription_billing_role_assignments" {
  description = "Configuration object - subscription billing roleassignments."
  default     = {}
}

variable "billing" {
  description = "Configuration object - Billing information."
  default     = {}
}

variable "remote_objects" {
  description = "Allow the landing zone to retrieve remote tfstate objects and pass them to the CAF module."
  default     = {}
}

## Diagnostics settings
variable "diagnostics_definition" {
  default     = null
  description = "Configuration object - Shared diadgnostics settings that can be used by the services to enable diagnostics."
}

variable "diagnostics_destinations" {
  description = "Configuration object - Describes the destinations for the diagnostics."
  default     = null
}

variable "log_analytics" {
  description = "Configuration object - Log Analytics resources."
  default     = {}
}

variable "diagnostics" {
  description = "Configuration object - Diagnostics object."
  default     = {}
}

variable "event_hub_namespaces" {
  description = "Configuration object - Diagnostics object."
  default     = {}
}

# variable "subnet_id" {
#   default = {}
# }

variable "user_type" {
  description = "The rover set this value to user or serviceprincipal. It is used to handle Azure AD API consents."
  default     = {}
}



variable "data_factory" {
  description = "Configuration object - Azure Data Factory resources"
  default     = {}
}

variable "logic_app" {
  description = "Configuration object - Azure Logic App resources"
  default     = {}
}


## Networking variables
variable "networking" {
  description = "Configuration object - networking resources"
  default     = {}
}

## Security variables
variable "security" {
  description = "Configuration object - security resources"
  default     = {}
}

variable "managed_identities" {
  description = "Configuration object - Azure managed identity resources"
  default     = {}
}


variable "custom_role_definitions" {
  description = "Configuration object - Custom role definitions"
  default     = {}
}


variable "var_folder_path" {
  default = ""
}


variable "identity" {
  description = "Configuration object - identity resources"
  default     = {}
}


variable "resource_provider_registration" {
  default = {}
}