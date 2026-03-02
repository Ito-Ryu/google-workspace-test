module "collab_groups" {
  source = "../../modules/collaboration-groups"

  project_name  = var.project_name
  collab_groups = var.collab_groups
}

module "collab_external_groups" {
  source = "../../modules/collaboration-groups-external"

  project_name           = var.project_name
  collab_external_groups = var.collab_external_groups
}