# Organizational Groups Module

このモジュールは、組織の階層構造（本部・部・グループ・チーム等）に基づくグループアドレスを作成・管理するためのTerraformモジュールです。

## 命名規則
`org.<division(本部)>.<department(部)>.<group(グループ)>.<team(チーム)>@<ドメイン>`

* 例: `org.a.ab.abc.infra@example.com`

## 使い方

```hcl
module "organizational_groups" {
  source = "path/to/modules/organizational-groups"
  org_groups = [
    {
      division       = "a"
      department     = "ab"
      group          = "abc"
      team           = "infra"
      domain         = "example.com"
      member_address = ["user@example.com"]
      description    = "Division A Department AB Group ABC Infra Team"
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
| <a name="input_org_groups"></a> [org\_groups](#input\_org\_groups) | List of organizational groups. | <pre>list(object({<br/>    division       = string<br/>    department     = string<br/>    group          = string<br/>    team           = string<br/>    domain         = string<br/>    member_address = list(string)<br/>    description    = string<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_groups"></a> [groups](#output\_groups) | The created Google Cloud Identity Groups. |
<!-- END_TF_DOCS -->