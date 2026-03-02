
variable "project_name" {
  description = "Project Name"
  type        = string
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
