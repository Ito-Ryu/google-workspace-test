locals {
  groups = {
    for g in var.collab_external_groups : "${g.target}-${g.role}" => g
  }

  group_members = flatten([
    for g in var.collab_external_groups : [
      for m in g.member_address : {
        group_key = "${g.target}-${g.role}"
        member    = m
      }
    ]
  ])

  members_map = {
    for gm in local.group_members : "${gm.group_key}-${gm.member}" => gm
  }
}

resource "google_cloud_identity_group" "group" {
  for_each     = local.groups
  display_name = "${var.project_name}.external.collab.${each.value.target}-${each.value.role}"
  parent       = "customers/C0123abcd"

  group_key {
    id = lower("${var.project_name}.external.collab.${each.value.target}-${each.value.role}@${each.value.domain}")
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }

  description = each.value.description
}

resource "google_cloud_identity_group_membership" "members" {
  for_each = local.members_map
  group    = google_cloud_identity_group.group[each.value.group_key].id

  preferred_member_key {
    id = each.value.member
  }

  roles {
    name = "MEMBER"
  }
}
