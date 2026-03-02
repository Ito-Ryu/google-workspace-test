# Design Doc: モジュール設計におけるドメイン名の制限

## Status
In Review

## 概要 (Overview)
Google Group Terraform モジュールにおいて、意図しないドメインでグループが作成されることを防ぐため、入力変数に対して Terraform ネイティブの `validation` ブロックを用いたドメイン名の制限を行う設計ドキュメント。

## 背景・目的 (Context & Goals)
これまでの設計では、各モジュール（`access-groups`, `collaboration-groups` 等）に渡す `domain` 変数には任意の文字列が入力可能であった。そのため、タイポや意図的な設定ミスにより、組織外のドメイン（例: `gmail.com` や誤ったスペルのドメイン）を用いた不正なグループが作成されてしまうリスクがあった。

静的解析ツール（Trivy/tfsec, Conftest等）によるCIでのチェックも有効だが、より開発サイクルの早い段階（`terraform plan` 実行時）でフィードバックを得るため、Terraform モジュール自身にバリデーションを組み込むことを目的とする。

## 目標と非目標 (Goals & Non-Goals)

### Goals (目標)
- [x] Terraform モジュール側で、許可されたドメインのみを受け付けるようにする。
- [x] 誤ったドメインが入力された場合、`terraform plan` の段階で即座にエラーとして弾く。
- [x] 利用者に分かりやすいエラーメッセージを表示する。

### Non-Goals (非目標)
- [ ] 動的なドメインリストの外部ファイルからの取得（今回は静的なリストとしてモジュール内に定義する）。
- [ ] 外部の静的解析ツール（Trivyなど）の CI パイプラインへの組み込み（これは副次的な防御レイヤーとして別途検討する）。

## 提案設計 (Proposed Design)

### 設計の要旨
各モジュールの `variables.tf` 内の変数定義に `validation` ブロックを追加する。
リスト内の各オブジェクトが持つ `domain` 属性を検証し、許可されたドメインのリスト（例: `["example.com"]`）に含まれているかを確認する。

### 実装例
`collaboration-groups` などの `variables.tf` において、以下のように `validation` ブロックを追加する。

```terraform
variable "collab_groups" {
  type = list(object({
    target         = string
    role           = string
    domain         = string
    member_address = list(string)
    description    = string
  }))
  description = "List of collab groups."
  default     = []

  validation {
    condition = alltrue([
      for g in var.collab_groups : contains(["example.com", "example2.com", "example3.com"], g.domain)
    ])
    error_message = "The domain must be one of: 'example.com', 'example2.com', 'example3.com'."
  }
}
```

#### ロジックの解説
- `for g in var.collab_groups : contains(["example.com", "example2.com", "example3.com"], g.domain)`:
  入力されたリスト（例: `collab_groups`）を展開し、それぞれのオブジェクト `g` の `domain` プロパティが `["example.com"]` リスト内に存在するか（`true` または `false`）を判定する。
- `alltrue(...)`:
  評価された boolean のリストが、すべて `true` である場合にのみ `true` を返す。一つでも不正なドメイン（`false`）があればバリデーション失敗となる。
- `error_message`:
  バリデーション失敗時にターミナル（または CI のログ）に出力されるエラーメッセージ。

## 影響・リスク (Impact & Risks)

- **運用面**:
  - 新たに別ドメイン（例: 子会社のドメインなど）を許可する必要が生じた場合、全モジュールの `variables.tf` 内の `contains` リストを修正して新しいバージョンをリリースする必要がある。
- **制約**:
  - Terraform の `validation` ブロック内の `condition` には、他の変数（`var.allowed_domains` のような動的なリスト）を参照できない制約があるため、ドメイン名はコード内にハードコードする必要がある。

## 検討した代替案 (Alternatives Considered)

| 案 | メリット | デメリット |
|---|---|---|
| **案A: Terraform `validation` (採用)** | 実装がシンプル。`plan` 時に即座にエラーが出るため開発体験が良い。追加ツールが不要。 | 許可するドメインを変更する際、全モジュールのコード修正が必要。 |
| **案B: Trivy (旧 tfsec) カスタムポリシー** | セキュリティチェックと統合できる。Terraformのコードを汚さない。 | 利用者がコードを書く段階（ローカル）ではなく、CI を回した時点で初めてエラーに気づくためフィードバックが遅い。Rego 言語の学習コスト。 |
| **案C: OPA / Conftest** | 生成されるリソースの値を厳密にチェックできる。 | 案Bと同様、CI 実行時までエラーに気づかない。事前の `terraform show -json` などの変換ステップが必要。 |

## 実装状況 (Implementation Status)

- [x] `access-groups` の変数に validation を追加
- [x] `collaboration-groups` の変数に validation を追加
- [x] `collaboration-groups-external` の変数に validation を追加
- [x] `enforcement-groups` の変数に validation を追加
- [x] `legacy-groups` の変数に validation を追加
- [x] `organizational-groups` の変数に validation を追加
