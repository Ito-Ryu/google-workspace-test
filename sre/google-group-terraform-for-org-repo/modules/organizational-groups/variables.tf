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

  validation {
    condition = alltrue([
      for g in var.org_groups : contains(["example.com", "example2.com", "example3.com"], g.domain)
    ])
    error_message = "The domain must be one of: 'example.com', 'example2.com', 'example3.com'."
  }
}