variable "project_name" {
  type        = string
  description = "Project Name"
}

variable "collab_groups" {
  type = list(object({
    target         = string
    role           = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of collab groups."
  default     = []
}

variable "collab_external_groups" {
  type = list(object({
    target         = string
    role           = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of collab external groups."
  default     = []
}

variable "access_groups" {
  type = list(object({
    role           = string
    job_function   = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of access groups."
  default     = []
}

variable "enforcement_groups" {
  type = list(object({
    group_description = string
    domain            = string
    member_address    = list(string)
    description       = string
  }))
  description = "List of enforcement groups."
  default     = []
}

variable "org_groups" {
  type = list(object({
    division       = string
    department     = string
    group          = string
    team           = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of organizational groups."
  default     = []
}

variable "legacy_groups" {
  type = list(object({
    group_name     = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of legacy groups."
  default     = []
}