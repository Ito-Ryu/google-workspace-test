project_name = "example-proj"

# --- Collaboration Groups (Internal) ---
collab_groups = [
  {
    target         = "a-system"
    role           = "developers"
    domain         = "example.com"
    member_address = ["xxx@example.com"]
    description    = "Example Project A System Developers"
  }
]

# --- Collaboration Groups (External) ---
collab_external_groups = [
  {
    target         = "a-system"
    role           = "developers"
    domain         = "example.com"
    member_address = ["ext@other.com"]
    description    = "Example Project A System Developers (External)"
  }
]

# --- Access Groups ---
access_groups = [
  {
    job_function   = "compute-engine"
    role           = "developers"
    domain         = "example.com"
    member_address = ["example-proj.collab.a-system-developers@example.com"]
    description    = "Compute Engine Developers Access Group"
  }
]

# --- Enforcement Groups ---
enforcement_groups = [
  {
    group_description = "corp-network-only"
    domain            = "example.com"
    member_address    = ["example-proj.external.collab.a-system-developers@example.com"]
    description       = "Enforcement group for corporate network only"
  }
]

# --- Organizational Groups ---
org_groups = [
  {
    division       = "a"
    department     = "ab"
    group          = "abc"
    team           = "infra"
    domain         = "example.com"
    member_address = ["aaa@example.com"]
    description    = "Division A Department AB Group ABC Infra Team"
  }
]

# --- Legacy Groups ---
legacy_groups = [
  {
    group_name     = "legacy-ml"
    domain         = "example.com"
    member_address = ["user@example.com"]
    description    = "A legacy distribution list"
  }
]