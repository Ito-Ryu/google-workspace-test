project_name = "PROJECT_NAME" # TODO: Change to your project name.

# --- Collaboration Groups (Internal) ---
# <project_name>.collab.<target>-<role>@<domain>
collab_groups = [
  {
    target = ""
    role   = ""
    domain = ""
    member_address = [
      ""
    ]
    description = ""
  }
]

# --- Collaboration Groups (External) ---
# <project_name>.external.<company_name>.collab.<target>-<role>@<domain>
collab_external_groups = [
  {
    company_name = ""
    target       = ""
    role         = ""
    domain       = ""
    member_address = [
      "",
    ]
    description = ""
  }
]

# --- Access Groups ---
# <project_name>.access.<target>-<role>@<domain>
access_groups = [
  {
    target = ""
    role   = ""
    domain = ""
    member_address = [
      ""
    ]
    description = ""
  }
]

# --- Enforcement Groups ---
# <project_name>.enforcement.<group_description>@<domain>
enforcement_groups = [
  {
    group_description = ""
    domain            = ""
    member_address = [
      ""
    ]
    description = ""
  }
]

# --- Old / Legacy Groups ---
# <group_name>@<domain>
legacy_groups = [
  {
    group  = ""
    domain = ""
    member_address = [
      ""
    ]
  }
]
