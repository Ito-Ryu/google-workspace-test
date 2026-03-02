locals {
  # URL (Internal module repository path)
  module_base_url = "git::https://github.com/private-org/terraform-google-group-for-org-repo.git//modules"
  module_version  = "v1.0.0" # Change according to the actual tag
}

module "org_groups" {
   source = "${local.module_base_url}/organaizational-groups?ref=${local.module_version}"

  org_groups   = var.org_groups
}
