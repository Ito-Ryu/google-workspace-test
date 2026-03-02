# Collaboration Groups Module

このモジュールは、各プロジェクト内の社内メンバー用コラボレーショングループを作成・管理するためのTerraformモジュールです。

## 命名規則
`<プロジェクト名>.collab.<対象(target)>-<役割(role)>@<ドメイン>`

* 例: `test.collab.a-system-developers@example.com`

## 使い方

```hcl
module "collaboration_groups" {
  source       = "path/to/modules/collaboration-groups"
  customer_id  = "C0123abcd"
  project_name = "test"
  collab_groups = [
    {
      target         = "a-system"
      role           = "developers"
      domain         = "example.com"
      member_address = ["user1@example.com", "user2@example.com"]
      description    = "A system developers group"
    }
  ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_identity_group.group](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group) | resource |
| [google_cloud_identity_group_membership.members](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group_membership) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_collab_groups"></a> [collab\_groups](#input\_collab\_groups) | List of collab groups. | <pre>list(object({<br/>    target         = string<br/>    role           = string<br/>    domain         = string<br/>    member_address = list(string)<br/>    description    = string<br/>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_groups"></a> [groups](#output\_groups) | The created Google Cloud Identity Groups. |
<!-- END_TF_DOCS -->