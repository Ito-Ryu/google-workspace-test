# Design Doc: 分散型 Google Group 管理アーキテクチャ

## Status
In Review

## 概要 (Overview)
Google Workspace の Google Group およびメンバー管理を、各プロジェクト・チームごとに委譲しつつ、セキュアかつ統制の取れた自動化を実現するためのアーキテクチャ設計。

各プロジェクトごとに Terraform リポジトリを分割し、プルリクエストによる承認フロー（CODEOWNERS）を導入することで、アジリティとセキュリティの両立を図る。

## 背景・目的 (Context & Goals)
### 現状の課題
1. **依頼フローによるタイムロス:** 現在、別チームがグループやメンバーの中央管理を行っており、追加や変更の依頼から反映までに時間がかかっている。
2. **外部ユーザーの管理不全:** 外部委託のユーザーの入れ替わりが激しく、中央管理では実態を把握しきれず、不要なユーザー（退場済みのメンバー等）がそのままグループに残ってしまうセキュリティリスクが発生している。
3. **情報隔離の必要性:** 外部ユーザーを含むため、あるチームのメンバー構成やアドレス一覧を、他のチームから見えないように隔離したい。

### 期待される価値
- 各チームが自律的にメンバー管理を行えるようになり、リードタイムが短縮される。
- チームリーダーが直接承認を行うことで、メンバーの実態（特に入退場）と権限が正しく同期される。
- チーム間の情報隔離が実現され、最小権限・最小情報開示の原則が守られる。

## 目標と非目標 (Goals & Non-Goals)
### Goals (目標)
- [x] プロジェクト（チーム）ごとにリポジトリを分割し、独立した管理スコープを提供する。
- [x] 他チームのグループやメンバー情報を互いに見えないようにする。
- [x] グループの作成・メンバー追加時に、そのプロジェクトのリーダーの承認（CODEOWNERS）を必須とするフローを構築する。
- [x] Google Cloud 環境を持たないプロジェクトでも Terraform を実行できるよう、中央の単一実行環境（単一の Service Account）を提供する。

### Non-Goals (非目標)
- [ ] Google Workspace 上のユーザーアカウント (Cloud Identity) 自体の作成や削除（オンボーディング/オフボーディング）プロセス。今回は「グループへの参加/脱退」にスコープを絞る。
- [ ] 既存の全グループの即時移行。新規プロジェクトおよび移行可能なプロジェクトから順次適用する。

## 提案設計 (Proposed Design)
### アーキテクチャ図
```text
[Project A Team]                 [Project B Team]
       | (PR & Merge)                   | (PR & Merge)
       v                                v
+----------------------+         +----------------------+
| Project A Repo       |         | Project B Repo       | <-- (隔離された情報)
| (CODEOWNERS: Leader) |         | (CODEOWNERS: Leader) |
+----------------------+         +----------------------+
       | (GitHub Actions)               | (GitHub Actions)
       |                                |
       +---------------+----------------+
                       |
                       v
            +--------------------+
            | Workload Identity  | (Federation)
            +--------------------+
                       |
                       v
            +--------------------+
            | Central GCP Project| (実行環境)
            | - Service Account  | (Group Admin Role)
            | - tfstate bucket   |
            +--------------------+
                       | (Cloud Identity API)
                       v
            +--------------------+
            | Google Workspace   |
            | (Groups & Members) |
            +--------------------+
```

### 設計の要旨
1. **リポジトリの分割:** プロジェクトごとに Terraform リポジトリ（例: `test-google-group-terraform`）を作成。これにより他チームからの可視性を物理的に遮断する。
2. **承認プロセスの強制:** 各リポジトリのルートまたは対象ディレクトリに `CODEOWNERS` を設定し、プロジェクトリーダーのレビューをマージ条件（Branch Protection）とする。
3. **中央実行環境の提供:** Terraform の実行（apply）と状態管理（tfstate）は、組織の SRE/Admin チームが管理する単一の Google Cloud プロジェクト (`google-group-management-terraform` で管理) に集約。
    - **Service Account (SA):** Google Group の作成権限を持つ唯一の SA を作成。
    - **Workload Identity:** 各プロジェクトリポジトリの GitHub Actions から、この SA を借用できるように OIDC 連携を設定する。

## 詳細設計 (Detailed Design)
### データモデル / スキーマ
* 各プロジェクトリポジトリは、社内共通の Terraform モジュール（`google-group-terraform-for-org-repo`）を呼び出す形でコードを記述する。
* Terraform の tfstate は、中央 GCP プロジェクト内の GCS バケットにて、プロジェクトごとにプレフィックス（パス）を分けて保存する。
  * `gs://google-group-tfstate/project-a/default.tfstate`
  * `gs://google-group-tfstate/project-b/default.tfstate`

### インターフェース / アクセス制御
1. **GitHub Repository:**
   - 閲覧権限 (Read): そのプロジェクトのメンバーのみ。
   - 書き込み権限 (Write): そのプロジェクトのメンバーのみ。
   - マージ権限 (Merge): CODEOWNERS（プロジェクトリーダー）の Apporve が必須。
2. **Workload Identity Pool:**
   - 中央の GCP プロジェクトに Pool を作成。
   - `attribute.repository` を条件に用いて、許可された特定のリポジトリからのアクセスのみを SA への借用として認可する。

## 検討した代替案 (Alternatives Considered)

| 案 | メリット | デメリット |
| :--- | :--- | :--- |
| **案A: 分散リポジトリ + 中央実行環境 (採用)** | チームごとの情報隔離が完全。各チームのクラウド環境の有無に依存しない。SAの権限管理が1箇所で済む。 | リポジトリ数が増えるため、セットアップの手間（Workload Identityの追加等）が都度発生する。 |
| **案B: 単一のモノレポでディレクトリ分割** | リポジトリが1つで済み、CI/CDの設定やモジュール参照が簡単。 | 外部ユーザーを含め、全チームのメンバー情報がリポジトリ参加者全員に見えてしまう（情報隔離の要件を満たせない）。 |
| **案C: 各プロジェクトのGCP環境で実行** | 中央環境のSPOF化を防げる。 | Google Cloud環境を持たないプロジェクトが対応できない。各プロジェクトに強い権限のSAを配る必要がありセキュリティリスクが高い。 |

## 影響・リスク (Impact & Risks)
- **セキュリティ:**
  - Workload Identity の設定ミスにより、意図しないリポジトリから特権 SA が利用されるリスク。
  - **対策:** SRE チームが Workload Identity のマッピング（`google-group-management-terraform-repo`）を厳格にコード管理し、レビューを行う。
- **運用:**
  - 新規プロジェクトが立ち上がるたびに、リポジトリ作成、CODEOWNERS設定、Workload Identity の紐付けという「初期セットアップ」のコストがかかる。
  - **対策:** 初期セットアップをテンプレート化（GitHub Template Repository 等）し、ドキュメント（`docs/setup.md`）を整備する。

## 実装プラン (Implementation Plan)
- [ ] フェーズ1: 中央実行環境の構築（GCP プロジェクト、SA、GCS バケット、基盤 Workload Identity の作成）。
- [ ] フェーズ2: 社内モジュール (`google-group-terraform-for-org`) の整備とルール定義。
- [ ] フェーズ3: パイロットプロジェクト (`project-test`) でのリポジトリ作成、CODEOWNERS 設定、パイプラインの動作検証。
- [ ] フェーズ4: 他プロジェクトへの水平展開、および運用ドキュメントの社内展開。
