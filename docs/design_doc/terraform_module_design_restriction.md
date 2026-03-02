# Design Doc: Google Group Terraform モジュール設計 (アドレス名の制限)

## Status
In Review

## 概要 (Overview)
Google Group の管理において、組織で定められた「Google Group 命名規則」をユーザーに意識させることなく強制適用し、宣言的なインフラ管理（IaC）を実現するための Terraform 共通モジュールの設計ドキュメント。

## 背景・目的 (Context & Goals)
ドキュメントベースの命名規則だけでは、手動運用によるミスやタイポ、意図的・非意図的な規則の逸脱を防ぐことが難しい。
Terraform による自動化プロセスの中で、入力変数を制限しモジュール内部でプレフィックス（接頭語）やフォーマットを組み立てる設計にすることで、**「システム的に命名規則を強制（Enforcement）する」** ことを目的とする。

## 目標と非目標 (Goals & Non-Goals)
### Goals (目標)
- [x] 利用者がグループ名全体（アドレス）を直接入力するのではなく、`target` や `role` などの要素を入力させることで、正しいアドレスを自動生成するモジュールを提供する。
- [x] メンバーの追加・削除の記述をリスト形式で簡単に行えるインターフェースを提供する。

### Non-Goals (非目標)
- [ ] 命名規則そのものの定義（別ドキュメント `docs/design_doc/google_group_name.md` にて定義）。
- [ ] Terraform 実行環境 (Workload Identity等) の構築。

## 提案設計 (Proposed Design)
### アーキテクチャ図
```text
[User (Project Team)]
  | 
  | (定義: target="a-system", role="developers")
  v
[project-xxx-repository / main.tf]
  |
  | (モジュール呼び出し)
  v
[terraform-google-group-for-org-repo (Shared Modules)]
  | - modules/collaboration-groups
  |   (内部で prefix を自動付与: test.collab.a-system-developers@...)
  v
[Google Cloud Identity API]
```

### 設計の要旨
モジュールはグループの種別ごとに分割（例: `collaboration-groups`, `access-groups` など）して提供する。
各モジュールの `variables.tf` では、自由記述の文字列ではなく `target`, `role`, `job_function` のような構造化された Object を要求し、`main.tf` 内部の `locals` と `for_each` を使って規則に沿った完全なアドレス（`group_key`）を自動生成する。

## 詳細設計 (Detailed Design)
### ロール一覧 (Role List)
各モジュールで指定可能な `role` は以下のいずれかに制限されます。

| 日本語名 | 英語名 (roleの値) |
| --- | --- |
| 開発者 | `developers` |
| 管理者 | `admins` |
| 運用者 | `operators` |
| 閲覧者 | `viewers` |
| 編集者 | `editors` |
| 保守担当 | `maintainers` |
| 承認者 | `approvers` |
| レビュー担当 | `reviewers` |
| 監査担当 | `auditors` |
| リーダー | `leads` |
| オーナー | `owners` |
| 利用者 | `users` |

### API / インターフェース
各モジュールに対するインターフェース（入力変数）の例。

#### 例: `collaboration-groups` モジュールの場合
利用側は以下のように要素だけを渡す。
```hcl
module "collab_groups" {
  source       = "..."
  project_name = "test"
  collab_groups = [
    {
      target         = "a-system"
      role           = "developers"
      domain         = "example.com"
      member_address = ["user@example.com"]
      description    = "説明"
    }
  ]
}
```

### コンポーネントの詳細
モジュール内部（`main.tf`）のロジック。

1. **グループアドレスの組み立て:**
   `project_name`, `target`, `role`, `domain` を文字列補間して `group_key` を生成する。
   ```hcl
   group_key {
     id = lower("${var.project_name}.collab.${each.value.target}-${each.value.role}@${each.value.domain}")
   }
   ```
2. **メンバーシップの展開:**
   入力が `member_address = list(string)` であるため、Terraformの `google_cloud_identity_group_membership` リソースで処理できるよう、`locals` ブロック内で `flatten()` を使い、グループキーとメンバーアドレスのペアに展開する。

## 検討した代替案 (Alternatives Considered)

| 案 | メリット | デメリット |
| :--- | :--- | :--- |
| **案A: モジュール側でプレフィックスを強制する (採用)** | 命名規則のブレが物理的に発生しない。 | 利用側が変数の構造（要素）を理解する必要がある。 |
| **案B: 汎用モジュールを利用し、正規表現でバリデーションする** | モジュールが1つ（汎用の workspace-group ）で済む。 | `validation` ブロックのエラーメッセージだけでは、ユーザーがどう直せばいいか分かりにくい。 |

## 影響・リスク (Impact & Risks)
- **運用**: メンバーが多数（数百〜数千人）いるグループの場合、Terraform の `for_each` で展開するリソース数が膨大になり、`terraform plan/apply` の実行時間が長くなる可能性がある。

## 実装プラン (Implementation Plan)
- [x] 各グループ種別（5種類）のモジュールディレクトリ作成。
- [x] `flatten()` を用いたメンバーシップ展開ロジックの実装。
- [x] `terraform-docs` によるモジュール仕様のドキュメント化。
