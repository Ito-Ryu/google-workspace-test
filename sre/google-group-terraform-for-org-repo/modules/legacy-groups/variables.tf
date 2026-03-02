
variable "legacy_groups" {
  type = list(object({
    group_name     = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of legacy groups."
}
