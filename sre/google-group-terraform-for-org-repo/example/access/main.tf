module "access_groups" {
  source = "../../modules/access-groups"

  project_name  = var.project_name
  access_groups = var.access_groups
}