resource "github_repository" "main" {
  name = var.github_repository

  has_issues   = true
  has_projects = true
  has_wiki     = true
  is_template  = true

  delete_branch_on_merge = true

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
}
