variable "product" {
  type        = "string"
  default     = "wa"
  description = "The name of your application"
}

variable "env" {
  type        = "string"
  description = "The deployment environment (sandbox, aat, prod etc..)"
}

variable "location" {
  type    = "string"
  default = "UK South"
}

variable "tenant_id" {
  type        = "string"
  description = "The Tenant ID of the Azure Active Directory"
}

variable "jenkins_AAD_objectId" {
  type        = "string"
  description = "This is the ID of the Application you wish to give access to the Key Vault via the access policy"
}

variable "wa_product_group_object_id" {
  type    = "string"
  default = "09cab722-d7e8-11ea-87d0-0242ac130003"
}

variable "team_name" {
  type        = "string"
  description = "Team name"
  default     = "Work Allocation"
}

variable "team_contact" {
  type        = "string"
  description = "Team contact"
  default     = "#workallocation"
}

variable "destroy_me" {
  type        = "string"
  description = "Here be dragons! In the future if this is set to Yes then automation will delete this resource on a schedule. Please set to No unless you know what you are doing"
  default     = "No"
}

variable "managed_identity_object_id" {
  default = ""
}
