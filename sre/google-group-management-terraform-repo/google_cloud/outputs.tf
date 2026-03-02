output "workload_identity_pool_name" {
  description = "作成されたWorkload Identity Poolの名前。"
  value       = google_iam_workload_identity_pool.mypool.name
}

output "workload_identity_pool_provider_name" {
  description = "作成されたWorkload Identity Pool Providerの名前。"
  value       = google_iam_workload_identity_pool_provider.myprovider.name
}

output "terraform_service_account_email" {
  description = "Workload Identity連携で使用されるサービスアカウントのメールアドレス。"
  value       = data.google_service_account.terraform_sa.email
}
