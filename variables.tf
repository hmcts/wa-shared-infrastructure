variable "product" {
  type        = string
  default     = "wa"
  description = "The name of your application"
}

variable "env" {
  type        = string
  description = "The deployment environment (sandbox, aat, prod etc..)"
}

variable "location" {
  type    = string
  default = "UK South"
}

variable "tenant_id" {
  type        = string
  description = "The Tenant ID of the Azure Active Directory"
}

variable "jenkins_AAD_objectId" {
  type        = string
  description = "This is the ID of the Application you wish to give access to the Key Vault via the access policy"
}

variable "wa_product_group_object_id" {
  type    = string
  default = "cdeb331b-adfe-46a7-a2c8-a628e2d35d96"
}

variable "team_name" {
  type        = string
  description = "Team name"
  default     = "Work Allocation"
}

variable "team_contact" {
  type        = string
  description = "Team contact"
  default     = "#workallocation"
}

variable "destroy_me" {
  type        = string
  description = "Here be dragons! In the future if this is set to Yes then automation will delete this resource on a schedule. Please set to No unless you know what you are doing"
  default     = "No"
}

variable "managed_identity_object_id" {
  default = ""
}

// as of now, UK South is unavailable for Application Insights
variable "appinsights_location" {
  type        = string
  default     = "West Europe"
  description = "Location for Application Insights"

}

variable "appinsights_application_type" {
  type        = string
  default     = "web"
  description = "Type of Application Insights (Web/Other)"
}

variable "common_tags" {
  type = map(string)
}
#this is the default value for any environment without a override file
variable "allowed_jurisdictions" {
  type        = string
  default = "'ia', 'IA', 'civil', 'CIVIL'"
  description = "Allowed jurisdictions ids for which ccd messages can be processed in case event handler"
}
