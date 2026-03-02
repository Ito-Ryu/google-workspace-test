# --- Enforcement Groups ---
enforcement_groups = [
  {
    group_description = "corp-network-only"
    domain            = "example.com"
    member_address    = ["example-proj.external.collab.b-system-developers@example.com"]
    description       = "Enforcement group for corporate network only"
  }
]