project_name = "test"

# --- Collaboration Groups (Internal) ---
# <project_name>.collab.<target>-<role>@<domain>
collab_groups = [
  {
    # test.collab.project-admins@example.com
    target = "project"
    role   = "admins"
    domain = "example.com"
    member_address = [
      "xxx@example.com",
      "yyy@example.com"
    ]
    description = "Test Project 管理者"
  },
  {
    # test.collab.develop-leaders@example.com
    target = "develop"
    role   = "leaders"
    domain = "example.com"
    member_address = [
      "aaa@example.com",
      "bbb@example.com",
      "ccc@example.com"
    ]
    description = "Test Project チームリーダー"
  },
  {
    # test.collab.a-system-developers@example.com
    target = "a-system"
    role   = "developers"
    domain = "example.com"
    member_address = [
      "aaa@example.com",
      "aaaa@example.com",
      "a1@example2.com"
    ]
    description = "Test Project Aシステム開発チーム"
  },
  {
    # test.collab.b-system-developers@example.com
    target = "b-system"
    role   = "developers"
    domain = "example.com"
    member_address = [
      "bbb@example.com",
      "bbbb@example.com",
      "bbbbb@example.com"
    ]
    description = "Test Project Bシステム開発チーム"
  },
  {
    # test.collab.c-system-developers@example.com
    target = "c-system"
    role   = "developers"
    domain = "example.com"
    member_address = [
      "ccc@example.com",
      "cccc@example.com",
      "ccccc@example.com",
      "c1@expamle2.com"
    ]
    description = "Test Project Cシステム開発チーム"
  },
  {
    # test.collab.infra-developers@example.com
    target = "infra"
    role   = "developers"
    domain = "example.com"
    member_address = [
      "iii@example.com",
      "iiii@example.com"
    ]
    description = "Test Project インフラ開発チーム"
  }
]

# --- Collaboration Groups (External) ---
# <project_name>.external.<company_name>.collab.<>(<target>-<role>)@<domain>
collab_external_groups = [
  {
    # test.external.abc-company.collab.a-system-developers@example.com
    company_name = "abc-company"
    target       = "a-system"
    role         = "developers"
    domain       = "example.com"
    member_address = [
      "AAA@abc-example.com",
      "BBB@abc-example.com"
    ]
    description = "Test Project Aシステム開発チーム（ABC会社）"
  },
  {
    # test.external.123-company.collab.a-system-developers@example.com
    company_name = "123-company"
    target       = "a-system"
    role         = "developers"
    domain       = "example.com"
    member_address = [
      "111@123-example.com",
      "222@123-example.com"
    ]
    description = "Test Project Aシステム開発チーム（123会社）"
  },
  {
    # test.external.123-company.collab.project-viewer@example.com
    company_name = "123-company"
    target       = "project"
    role         = "viewers"
    domain       = "example.com"
    member_address = [
      "333@123-example.com",
      "444@123-example.com"
    ]
    description = "Test Project 閲覧用"
  }
]

# --- Access Groups ---
# <project_name>.access.<target>-<role>@<domain>
access_groups = [
  {
    # test.access.api-develoers@example.com
    target = "api"
    role   = "develoers"
    domain = "example.com"
    member_address = [
      "test.collab.a-system-developers@example.com",
      "test.collab.b-system-developers@example.com",
      "test.collab.c-system-developers@example.com",
      "test.external.abc-company.collab.a-system-developers@example.com",
      "test.external.123-company.collab.a-system-developers@example.com"
    ]
    description = "Google Cloud (test) のアプリケーションの開発者権限を持つアクセスグループ"
  },
  {
    # test.access.a-bucket-developesr@example.com
    target = "a-system-bucket"
    role   = "developers"
    domain = "example.com"
    member_address = [
      "test.collab.a-system-viewer@example.com",
    ]
    description = "Google Cloud (test) の a-buket の権限を持つアクセスグループ"
  },
  {
    # test.access.network-developer@example.com
    target = "network"
    role   = "develoers"
    domain = "example.com"
    member_address = [
      "org.system-div.dinfra@example.com",
      "test.collab.infra-developers@example.com",
    ]
    description = "Google Cloud (test) の network の権限を持つアクセスグループ"
  },
  {
    # test.access.jumpserver-prod-users@example.com
    target = "jumpserver-prod"
    role   = "users"
    domain = "example.com"
    member_address = [
      "test.collab.a-system-developers@example.com",
      "test.collab.b-system-developers@example.com",
      "test.collab.c-system-developers@example.com",
      "test.external.abc-company.collab.a-system-developers@example.com",
      "test.external.123-company.collab.a-system-developers@example.com"
    ]
    description = "Google Cloud (test-prod) の jumpserver の権限を持つアクセスグループ"
  }
]

# --- Enforcement Groups ---
# <project_name>.enforcement.<group_description>@<domain>
enforcement_groups = [
  {
    # test.enforcement.corp-network-only@example.com
    group_description = "corp-network-only"
    domain            = "example.com"
    member_address = [
      "test.external.abc-company.collab.a-system-developers@example.com",
      "test.external.123-company.collab.a-system-developers@example.com",
      "test.external.123-company.collab.project-viewer@example.com"
    ]
    description = "Google Cloud で社内ネットワークを制限する適応グループ"
  }
]

# --- Old / Legacy Groups ---
# <group_name>@<domain>
legacy_groups = [
  {
    # abcdf@example.com
    group  = "abcdf"
    domain = "example.com"
    member_address = [
      "aaa@example.com",
      "bbb@example.com",
      "ccc@example.com"
    ]
  }
]
