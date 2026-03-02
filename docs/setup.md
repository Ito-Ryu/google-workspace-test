# 管理者向けセットアップ手順 (setup.md)

## 概要
本システムでは、全プロジェクトで共通の「Google Group 管理用 Service Account (`terraform-google-group`)」を利用します。
各リポジトリからの認証には「Workload Identity」を利用し、許可されたリポジトリのみがこの特権 SA を借用できる構成をとります。

---

## 1. プロジェクト準備 (手動/初期構築)
Google Group 管理実行環境および基盤となるリソースの準備を行います。これらはSREが手動または初期構築用の別スクリプト等で作成します。

### 1-1. プロジェクト用 GitHub リポジトリの作成
SRE 用の Terraform リポジトリを新規作成します。情報隔離のため、アクセス権は SRE のみに限定してください。
* **Github Repository (例):** `google-group-management-terraform`

### 1-2. Google Cloud プロジェクトの作成
中央管理用の Google Cloud プロジェクトを作成します。
* **Google Cloud Project (例):** `google-group-management`

### 1-3. tfstate 保存用 Storage の作成
Terraform の状態を管理する GCS バケットを作成します。
* **Google Cloud Storage (例):** `google-group-tfstate`

### 1-4. 基盤構築用 Service Account の作成
`google-group-management` 内で Workload Identity などを構築するための実行用 SA を作成し、Roleを付与します。
* **Service Account (例):** `terraform@<PROJECT_ID>.iam.gserviceaccount.com`
* **権限 (IAM Role):**
  * `roles/storage.objectUser`
  * `roles/iam.serviceAccountUser`
  * `roles/iam.serviceAccountAdmin`
  * `roles/serviceusage.serviceUsageAdmin`
  * `roles/iam.workloadIdentityPoolAdmin`

---

## 2. Terraform による実行環境の構築
準備した環境上で `google-group-management-terraform` の Terraform を実行し、各プロジェクトに提供する共通リソースを構築します。

### 2-1. Google Group 管理用 Service Account の作成 (共有リソース)
組織全体に対してグループ操作権限を持つ、各プロジェクトが **Providerとして利用する** 特権 SA を作成します。
* **Service Account (例):** `terraform-google-group@<PROJECT_ID>.iam.gserviceaccount.com`
* **権限 (IAM Role):**
  * `roles/storage.objectUser`
  * `roles/networkconnectivity.groupAdmin`

*(※本リポジトリではこのSAの「作成自体」は手動/別管理とし、後続の紐付けのみをTerraformで行う設計でも可)*

### 2-2. Workload Identity 基盤のセットアップ
GitHub Actions から特権 SA を借用するための基盤を作成します。
1. **Workload Identity Pool の作成** (`github-actions-pool`)
2. **Workload Identity Provider の作成** (`https://token.actions.githubusercontent.com`)

### 2-3. リポジトリの追加・共有設定 (コードの修正と適用)
新しいプロジェクトリポジトリが作成された際、この共通基盤を利用できるように許可設定を追加します。

1. **`sre/google-group-management-terraform-repo` への追記**
   `terraform.tfvars` の `github_repositories` リストに、新しく作成したリポジトリ名を追加し、Terraform を Apply します。
   ```hcl
   github_repositories = [
     "your-org/org-google-group-terraform-repo",
     "your-org/test-google-group-terraform-repo",
     "your-org/new-project-repo" # ここに追加
   ]
   ```
   これにより、指定したリポジトリに対して `terraform-google-group` SA を借用する権限 (`roles/iam.workloadIdentityUser`) が付与されます。

---

## 3. プロジェクトへの共有作業
SRE は、上記で構築・許可した情報を各プロジェクトチームに共有・設定します。

### 3-1. GitHub Secrets の追加
新しく追加したプロジェクトのリポジトリ（例: `new-project-repo`）の `Settings > Secrets and variables > Actions` に、以下の情報を登録します。

* **`GCP_WORKLOAD_IDENTITY_PROVIDER`**: 作成した Provider の完全な識別子
  * (例: `projects/123456789/locations/global/workloadIdentityPools/github-actions-pool/providers/github-provider`)*
* **`GCP_SERVICE_ACCOUNT_EMAIL`**: プロジェクトが Provider として利用する特権 SA のメールアドレス
  * (例: `terraform-google-group@<PROJECT_ID>.iam.gserviceaccount.com`)*

これで、各プロジェクトは自身の CI/CD パイプラインから、中央の特権 SA を安全に利用して Google Group を管理できるようになります。
