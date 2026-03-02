project_name = "example-proj"

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