# Google Cloud
project_id = "google-group-management"
project_number = 123456789

# 有効化する GCP API
enabled_services = [
  "iam.googleapis.com",
  "cloudresourcemanager.googleapis.com",
  "iamcredentials.googleapis.com",
  "sts.googleapis.com"
]

# 連携するGitHubリポジトリ
github_repositories = [
  "your-org/terraform-google-group-for-org-repo",
  "your-org/org-google-group-terraform-repo",
  "your-org/test-google-group-terraform-repo"
]

# リージョン
region = "asia-northeast1"

# 既存のサービスアカウントID
terraform_service_account_id = "terraform-google-group"

# Workload Identity Pool/Provider ID
workload_identity_pool_id = "github-pool"
workload_identity_pool_provider_id = "github-provider"
