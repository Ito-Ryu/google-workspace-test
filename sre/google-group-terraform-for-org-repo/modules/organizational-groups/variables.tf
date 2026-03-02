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
}