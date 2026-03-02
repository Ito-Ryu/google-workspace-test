# google-workspace-test

## リポジトリの構成と役割
本システムは以下のリポジトリ構成で Google Workspace Group の管理を行います。

| ディレクトリ | リポジトリ名 | 役割 |
|---|---|---|
| **sre/** | **terraform-google-group-for-org-repo** | Google Workspace Group 用の社内用 Terraform モジュールを保管するリポジトリ。 |
| | **google-group-management-terraform-repo** | GitHub Actions 用の Workload Identity などを管理するリポジトリ。 |
| **org/** | **org-google-group-terraform-repo** | 実際の Workload Identity や共通リソースなどを管理する実行環境となるリポジトリ。 |
| **project-test/** | **test-google-group-terraform-repo** | 各プロジェクトごとに Google グループの作成やメンバー追加を行うためのリポジトリ。 |
| | **test-terraform-repo** | 作成したグループに対して IAM 権限を付与するためのリポジトリ。 |

## 各情報の例
### Google Cloud Project
project_id = "google-group-management"
project_number = 123456789

### Terraform
Service Account = "terraaform@google-group-management"

## 手順
### 1. Github Apps の作成

## 資料
https://developer.hashicorp.com/terraform/language/modules/configuration