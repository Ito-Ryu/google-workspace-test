variable "project_name" {
  type        = string
  description = "Project Name"
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
  default     = []
}