variable "org_groups" {
  type = list(object({
    division       = optional(string) # 事業部 (〇〇本部)
    department     = optional(string) # 部署 (〇〇部)
    group          = optional(string) # (〇〇課/係)
    team           = string           # チーム (〇〇チーム)
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of org groups."
}
