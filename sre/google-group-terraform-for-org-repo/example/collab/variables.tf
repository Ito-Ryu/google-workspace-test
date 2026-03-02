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