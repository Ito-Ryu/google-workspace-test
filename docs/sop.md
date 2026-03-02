# プロジェクト向け 標準作業手順書 (SOP)

## 目的
各プロジェクトのチームが、自律的に Google Group を管理・運用するための環境構築および運用手順を記載します。
新規プロジェクトが立ち上がった際や、新しいチームがグループ管理を開始する際にこの手順に従います。

## 環境構築手順 (オンボーディング)
### 1. プロジェクト用 GitHub リポジトリの作成
チーム専用の Terraform リポジトリを新規作成します。
外部ユーザーの情報などを隔離するため、このリポジトリのアクセス権は該当チームのメンバー（および SRE/Admin）のみに限定してください。

```text
# e.g.
`<PROJECT_NAME>-google-group-terraform`
```

### 2. GitHub Secrets の設定 (SRE/Admin 作業推奨)
リポジトリが作成されたら、中央実行環境にアクセスするための認証情報を設定します。
セキュリティの観点から、この作業は SRE/Admin が実施することを推奨します。

対象リポジトリの `Settings > Secrets and variables > Actions` にて、以下の値を登録します。
* `GCP_WORKLOAD_IDENTITY_PROVIDER`: (SREが発行したProviderの値)
* `GCP_SERVICE_ACCOUNT_EMAIL`: (SREが発行したSAアドレス)

### 3. Terraform コードのコピー
社内モジュールリポジトリ (`google-group-terraform-for-org`) の `examples` ディレクトリから、ベースとなる Terraform コード (`main.tf`, `variables.tf`, `backend.tf`, `terraform.tfvars`) を、作成したリポジトリにコピーします。

* **注意:** `backend.tf` の `prefix` は、他チームと競合しないようにプロジェクト名（例: `project-a`）に変更してください。

### 4. GitHub Actions ワークフローのコピー
社内モジュールリポジトリ (`google-group-terraform-for-org`) の `.github/examples` ディレクトリから、共通で用意されている CI/CD パイプラインの設定ファイルをコピーし、`.github/workflows/` 以下に配置します。
* `terraform-plan.yaml`: PR 作成時に自動で plan を実行する
* `terraform-apply.yaml`: main ブランチへのマージ時に自動で apply を実行する

### 5. CODEOWNERS の追加
リポジトリのルート（または `.github/` ディレクトリ）に `CODEOWNERS` ファイルを作成し、グループの作成やメンバー追加を承認できる**プロジェクトリーダー**を指定します。

```text
# .github/CODEOWNERS
* @project-leader-github-id
```
あわせて、GitHub の Branch Protection ルールで「Require review from Code Owners」を有効化してください。

### 6. tfvars の修正と初回適用
`terraform.tfvars` を自プロジェクトに合わせて修正します。
* `project_name` の設定
* 初期グループ（collab, access 等）の定義

修正後、Pull Request を作成し、CODEOWNERS の承認を得て main にマージすることで初期構築が完了します。