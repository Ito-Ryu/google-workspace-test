## API の有効化 (Workload Identity 用)
resource "google_project_service" "enable_api" {
  for_each                   = toset(var.enabled_services)
  project                    = var.project_id
  service                    = each.value
  disable_dependent_services = true
}

# Workload Identity Pool 設定
resource "google_iam_workload_identity_pool" "mypool" {
  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = var.workload_identity_pool_id
  description               = "GitHub Actions 用"
}

# Workload Identity Provider 設定
resource "google_iam_workload_identity_pool_provider" "myprovider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.mypool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  display_name                       = var.workload_identity_pool_provider_id
  description                        = "GitHub Actions 用"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# GitHub Actions が借用する既存のサービスアカウントを取得
data "google_service_account" "terraform_sa" {
  account_id = var.terraform_service_account_id
}

# 指定したすべての GitHub リポジトリに対して、既存のサービスアカウントの借用権限（Workload Identity User）のみを付与
resource "google_service_account_iam_member" "terraform_sa" {
  for_each           = toset(var.github_repositories)
  service_account_id = data.google_service_account.terraform_sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.mypool.name}/attribute.repository/${each.value}"
}
