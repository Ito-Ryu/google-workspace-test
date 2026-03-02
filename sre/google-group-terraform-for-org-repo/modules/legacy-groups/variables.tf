variable "legacy_groups" {
  type = list(object({
    group_name     = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of legacy groups."
  default     = []

  validation {
    condition = alltrue([
      for g in var.legacy_groups : contains(["example.com", "example2.com", "example3.com"], g.domain)
    ])
    error_message = "The domain must be one of: 'example.com', 'example2.com', 'example3.com'."
  }
}
