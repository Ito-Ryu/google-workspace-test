project_name = "test2"

# --- Collaboration Groups (Internal) ---
# <project_name>.collab.<target>-<role>@<domain>
collab_groups = [
  {
    # test2.collab.project-admins@example2.com
    target = "project"
    role   = "admins"
    domain = "example2.com"
    member_address = [
      "x1@example.com"
    ]
    description = "Test2 Project 管理者"
  },
  {
    # test2.collab.develop-leaders@example2.com
    target = "develop"
    role   = "leaders"
    domain = "example2.com"
    member_address = [
      "a1@example2.com",
      "a2@example2.com",
      "a3@example2.com"
    ]
    description = "Test2 Project チームリーダー"
  },
  {
    # test2.collab.1-system-developers@example2.com
    target = "1-system"
    role   = "developers"
    domain = "example2.com"
    member_address = [
      "a1@example2.com",
      "a2@example2.com",
      "aaa@example.com"
    ]
    description = "Test2 Project Aシステム開発チーム"
  },
  {
    # test2.collab.2-system-developers@example2.com
    target = "2-system"
    role   = "developers"
    domain = "example2.com"
    member_address = [
      "b1@example2.com",
      "b2@example2.com",
      "b3@example2.com"
    ]
    description = "Test2 Project Bシステム開発チーム"
  },
  {
    # test2.collab.3-system-developers@example2.com
    target = "3-system"
    role   = "developers"
    domain = "example2.com"
    member_address = [
      "c1@example2.com",
      "c2@example2.com",
      "c3@example2.com",
      "ccc@expamle.com"
    ]
    description = "Test2 Project Cシステム開発チーム"
  },
  {
    # test2.collab.infra-developers@example2.com
    target = "infra"
    role   = "developers"
    domain = "example2.com"
    member_address = [
      "i1@example2.com",
      "i2@example2.com"
    ]
    description = "Test2 Project インフラ開発チーム"
  }
]

# --- Access Groups ---
# <project_name>.access.<target>-<role>@<domain>
access_groups = [
  {
    # test2.access.api-develoers@example2.com
    target = "api"
    role   = "develoers"
    domain = "example2.com"
    member_address = [
      "test2.collab.1-system-developers@example2.com",
      "test2.collab.2-system-developers@example2.com",
      "test2.collab.3-system-developers@example2.com",
    ]
    description = "Google Cloud (test2) のアプリケーションの開発者権限を持つアクセスグループ"
  },
  {
    # test2.access.network-developer@example2.com
    target = "network"
    role   = "develoers"
    domain = "example2.com"
    member_address = [
      "org.system-div.dinfra@example.com",
      "test2.collab.infra-developers@example2.com",
    ]
    description = "Google Cloud (test2) の network の権限を持つアクセスグループ"
  },
  {
    # test2.access.jumpserver-prod-users@example2.com
    target = "jumpserver-prod"
    role   = "users"
    domain = "example2.com"
    member_address = [
      "test2.collab.1-system-developers@example2.com",
      "test2.collab.2-system-developers@example2.com",
      "test2.collab.3-system-developers@example2.com"
    ]
    description = "Google Cloud (test2-prod) の jumpserver の権限を持つアクセスグループ"
  }
]
