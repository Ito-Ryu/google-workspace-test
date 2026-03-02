# Old Groups Module

このモジュールは、従来の命名規則を持たない既存のグループアドレスを作成・管理するためのTerraformモジュールです。  
接頭語の自動付与は行われず、指定したグループ名がそのまま利用されます。

## 命名規則
`<指定したグループ名(group_name)>@<ドメイン>`

* 例: `legacy-group@example.com`

## 使い方

```hcl
module "legacy_groups" {
  source      = "path/to/modules/old-groups"
  customer_id = "C0123abcd"
  legacy_groups  = [
    {
      group_name     = "legacy-group"
      domain         = "example.com"
      member_address = ["user@example.com"]
      description    = "Legacy group"
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
| <a name="input_legacy_groups"></a> [legacy\_groups](#input\_legacy\_groups) | List of legacy groups. | <pre>list(object({<br/>    group_name     = string<br/>    domain         = string<br/>    member_address = list(string)<br/>    description    = string<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_groups"></a> [groups](#output\_groups) | The created Google Cloud Identity Groups. |
<!-- END_TF_DOCS -->