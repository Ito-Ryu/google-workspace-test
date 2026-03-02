locals {
  # URL (Internal module repository path)
  module_base_url = "git::https://github.com/private-org/terraform-google-group-for-org-repo.git//modules"
  module_version  = "v1.0.0" # Change according to the actual tag
}

# --- Collaboration Groups (Internal) ---
module "collab_groups" {
  source = "${local.module_base_url}/collaboration-groups?ref=${local.module_version}"

  project_name  = var.project_name
  collab_groups = var.collab_groups
}

# --- Collaboration Groups (External) ---
module "collab_external_groups" {
  source = "${local.module_base_url}/collaboration-groups-external?ref=${local.module_version}"

  project_name           = var.project_name
  collab_external_groups = var.collab_external_groups
}

# --- Access Groups ---
module "access_groups" {
  source = "${local.module_base_url}/access-groups?ref=${local.module_version}"

  project_name  = var.project_name
  access_groups = var.access_groups
}

# --- Enforcement Groups ---
module "enforcement_groups" {
  source = "${local.module_base_url}/enforcement-groups?ref=${local.module_version}"

  enforcement_groups = var.enforcement_groups
}

# --- Old / Legacy Groups ---
module "legacy_groups" {
  source = "${local.module_base_url}/legacy-group?ref=${local.module_version}"


  project_name  = var.project_name
  legacy_groups = var.legacy_groups
}
