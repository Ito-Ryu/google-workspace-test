# Design Doc: Google Group 命名規則

## Status
In Review

## 概要 (Overview)
Google Workspace における Google Group の乱立を防ぎ、IAM などでの用途を明確にするため、グループの命名規則を定める。

※本ドキュメントは「命名規則」そのものに焦点を当てており、これを強制・自動化するための Terraform モジュールの設計については別途ドキュメントを参照すること。

## 背景・目的 (Context & Goals)
Google Group の管理において、用途が不明確なグループが乱立する課題があった。
- 誰が何の目的で作成したグループかわからなくなる
- 外部メンバーを含むグループかどうかの判別がつきにくい
- Google Cloud IAM の権限付与に使われるグループか、単なるメーリングリストか判断しづらい

これらを解決し、セキュアで可読性の高いグループ管理を実現する。

## 目標と非目標 (Goals & Non-Goals)
### Goals (目標)
- [x] 用途ごとに明確な命名規則を定義する。
- [x] 外部のユーザーが含まれるグループを識別しやすくする。

### Non-Goals (非目標)
- [ ] 既存グループの命名変更。
- [ ] ユーザーごとのライセンス管理や組織部門 (OU) の詳細な構成。
- [ ] 命名規則を強制するための Terraform モジュールの設計・実装（別ドキュメントで定義）。

## 提案設計 (Proposed Design)
### 設計の要旨
グループの用途を大きく5つに分類し、それぞれの命名規則（プレフィックスやフォーマット）を定義する。
これにより、グループのアドレスを見るだけで「どのプロジェクトの」「誰向け（社内外）の」「何の目的の」グループであるかが一目でわかる状態を目指す。

## 詳細設計 (Detailed Design)
### グループ種別と命名規則

#### 1. Collaboration Groups
* **用途**: 社内メンバー間でのコラボレーションや連絡用
* **命名規則**: `<プロジェクト名(project_name)>.collab.<対象(target)>-<役割(role)>@<ドメイン>`
* **例**: `test.collab.a-system-developers@example.com`

#### 2. External Collaboration Groups
* **用途**: 社外メンバー（ベンダーやパートナー等）を含むコラボレーション用
* **命名規則**: `<プロジェクト名(project_name)>.external.<会社名(company_name)>.collab.<対象(target)>-<役割(role)>@<ドメイン>`
* **例**: `test.external.abc-company.collab.a-system-developers@example.com`

#### 3. Access Groups
* **用途**: Google Cloud の IAM ロール等、リソースアクセス権限を付与するためのグループ。原則としてこのグループには個人アドレスではなく Collab グループを所属させる。
* **命名規則**: `<プロジェクト名(project_name)>.access.<機能(job_function)>-<役割(role)>@<ドメイン>`
* **例**: `test.access.compute-engine-developers@example.com`

#### 4. Enforcement Groups
* **用途**: 特殊なポリシーやセキュリティ制約（MFA必須など）を適用するためのグループ。
* **命名規則**: `<プロジェクト名(project_name)>.enforce.<グループ説明(group_description)>@<ドメイン>`
* **例**: `test.enforce.mfa-required@example.com`

#### 5. Organizational Groups
* **用途**: 組織の階層構造（本部・部・グループ・チーム等）に基づく全社的なメーリングリストやグループ。
* **命名規則**: `org.<division(本部)>.<department(部)>.<group(グループ)>.<team(チーム)>@<ドメイン>`
* **例**: `org.a.ab.abc.infra@example.com`

#### 6. Legacy Groups
* **用途**: 既存のシステムや運用で利用されており、上記の命名規則に当てはめるのが難しい従来のグループ。
* **命名規則**: 接頭語なし (`<group_name>@<ドメイン>`)
* **例**: `legacy-ml@example.com`

## 影響・リスク (Impact & Risks)
- **セキュリティ**: Access Groups に個人アドレスを直接入れないことで、権限の棚卸しと管理を容易にする。External を明示的に分けることで、情報漏洩のリスクを低減する。
- **運用**: 新しい命名規則の浸透には、作成者へのルール周知が必要となる。

## 参考資料 (References)
- 命名規則の参考: [IAM 向け Google グループのベスト プラクティス](https://docs.cloud.google.com/iam/docs/groups-best-practices)