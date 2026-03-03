# Enforcement Groups Module

このモジュールは、組織のポリシー適用など、特殊な制約やエンフォースメントを行うためのグループを作成・管理するためのTerraformモジュールです。

## 命名規則
`enforce.<グループ説明(group_description)>@<ドメイン>`

* 例: `enforce.mfa-required@example.com`

## 使い方

```hcl
module "enforcement_groups" {
  source             = "path/to/modules/enforcement-groups"
  project_name       = "test"
  enforcement_groups = [
    {
      group_description = "mfa-required"
      domain            = "example.com"
      member_address    = ["user@example.com"]
      description       = "MFA required enforcement group"
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
| <a name="input_enforcement_groups"></a> [enforcement\_groups](#input\_enforcement\_groups) | List of enforcement groups. | <pre>list(object({<br/>    group_description = string<br/>    domain            = string<br/>    member_address    = list(string)<br/>    description       = string<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_groups"></a> [groups](#output\_groups) | The created Google Cloud Identity Groups. |
<!-- END_TF_DOCS -->