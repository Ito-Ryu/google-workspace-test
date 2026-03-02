variable "project_id" {
  type        = string
  description = "GCPプロジェクトのID。"
}

variable "project_number" {
  type        = number
  description = "GCPプロジェクトのNumber。"
}

variable "region" {
  type        = string
  description = "GCPリソースを作成するリージョン。"
  default     = "asia-northeast1"
}

variable "enabled_services" {
  type        = list(string)
  description = "有効化するGCP APIのリスト。"
  default     = []
}

variable "github_repositories" {
  type        = list(string)
  description = "連携するGitHubリポジトリのリスト (例: ['owner/repo1', 'owner/repo2'])。"
}

variable "terraform_service_account_id" {
  type        = string
  description = "既存のサービスアカウントのID (メールアドレスの@より前の部分)。"
}

variable "workload_identity_pool_id" {
  type        = string
  description = "Workload Identity PoolのID（32文字以下）。"
  default     = "github-pool"
}

variable "workload_identity_pool_provider_id" {
  type        = string
  description = "Workload Identity Pool ProviderのID（32文字以下）。"
  default     = "github-provider"
}
