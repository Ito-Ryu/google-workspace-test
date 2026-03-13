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
}

variable "enforcement_groups" {
  type = list(object({
    group_description = string
    domain            = string
    member_address    = list(string)
    description       = string
  }))
  description = "List of enforcement groups."
}

variable "legacy_groups" {
  type = list(object({
    group          = string
    domain         = string
    member_address = list(string)
    description    = optional(string)
  }))
  description = "List of workspace groups."
}
