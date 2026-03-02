
variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "access_groups" {
  type = list(object({
    job_function   = string
    role           = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of access groups."
}
