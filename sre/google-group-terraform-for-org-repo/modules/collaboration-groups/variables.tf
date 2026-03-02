variable "project_name" {
  description = "Project Name"
  type        = string
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

  validation {
    condition = alltrue([
      for g in var.collab_groups : contains(["example.com", "example2.com", "example3.com"], g.domain)
    ])
    error_message = "The domain must be one of: 'example.com', 'example2.com', 'example3.com'."
  }
}
