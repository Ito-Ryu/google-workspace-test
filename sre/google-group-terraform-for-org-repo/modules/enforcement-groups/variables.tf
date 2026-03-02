
variable "enforcement_groups" {
  type = list(object({
    group_description = string
    domain            = string
    member_address    = list(string)
    description       = string
  }))
  description = "List of enforcement groups."
  default     = []

  validation {
    condition = alltrue([
      for g in var.enforcement_groups : contains(["example.com", "example2.com", "example3.com"], g.domain)
    ])
    error_message = "The domain must be one of: 'example.com', 'example2.com', 'example3.com'."
  }
}
