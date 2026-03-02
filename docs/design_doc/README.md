# Design Doc: 設計ドキュメント群 (Design Documents)

このディレクトリ（`docs/design_doc`）には、Google Workspace における Google Group の分散管理、Terraform による自動化、および関連する設計・アーキテクチャの意思決定に関する Design Doc が格納されています。「なぜそのような構成にするのか（Why）」や「どのような制約・仕組みなのか（What）」といった**設計とルール**を定義しています。

## 格納されているドキュメント

| ファイル名 | 概要 | 主な内容 |
| :--- | :--- | :--- |
| `decentralized_google_group_management.md` | 分散型 Google Group 管理 | プロジェクトチームが分散して管理するためのアーキテクチャ・フロー設計 |
| `google_group_name.md` | Google Group 命名規則 | 用途ごとの明確なプレフィックスやフォーマットの定義 |
| `terraform_module_design_restriction.md` | Terraform モジュール設計 (名称制約) | モジュール内部で命名規則を自動生成し、強制適用(Enforcement)するための設計 |
| `terraform_module_domain_restriction.md` | Terraform モジュール設計 (ドメイン制約) | 設定可能なドメインを制限し、不正なドメインを弾くための設計 |