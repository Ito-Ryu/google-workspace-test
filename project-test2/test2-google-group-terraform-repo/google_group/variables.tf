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
