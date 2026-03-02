
variable "enforcement_groups" {
  type = list(object({
    group_description = string
    domain            = string
    member_address    = list(string)
    description       = string
  }))
  description = "List of enforcement groups."
}
