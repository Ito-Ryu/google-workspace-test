# Access Groups Module

このモジュールは、Google Cloud IAM の権限付与などのリソースアクセスを目的としたアクセスグループを作成・管理するためのTerraformモジュールです。

## 命名規則
`access.<プロジェクト名>.<機能(job_function)>-<役割(role)>@<ドメイン>`

* 例: `access.test.compute-engine-developers@example.com`

## 使い方

```hcl
module "access_groups" {
  source       = "path/to/modules/access-groups"
  project_name = "test"
  access_groups = [
    {
      job_function   = "compute-engine"
      role           = "developers"
      domain         = "example.com"
      member_address = ["test.collab.a-system-developers@example.com"]
      description    = "Compute Engine developers access group"
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
| <a name="input_access_groups"></a> [access\_groups](#input\_access\_groups) | List of access groups. | <pre>list(object({<br/>    job_function   = string<br/>    role           = string<br/>    domain         = string<br/>    member_address = list(string)<br/>    description    = string<br/>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_groups"></a> [groups](#output\_groups) | The created Google Cloud Identity Groups. |
<!-- END_TF_DOCS -->