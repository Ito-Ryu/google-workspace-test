project_name = "example-proj"

# --- Collaboration Groups (Internal) ---
collab_groups = [
  {
    target         = "a-system"
    role           = "developers"
    domain         = "example.com"
    member_address = ["user1@example.com", "user2@example.com"]
    description    = "A System Developers"
  }
]

# --- Collaboration Groups (External) ---
collab_external_groups = [
  {
    target         = "b-system"
    role           = "developers"
    domain         = "example.com"
    member_address = ["ext-user@other-example.com"]
    description    = "B System Developers (External)"
  }
]