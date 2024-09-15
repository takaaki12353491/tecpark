resource "github_repository" "main" {
  name = var.github_repository

  has_issues   = true
  has_projects = true
  has_wiki     = true
  is_template  = true

  delete_branch_on_merge = true
}

resource "github_actions_secret" "atlas_cloud_token" {
  repository      = var.github_repository
  secret_name     = "ATLAS_CLOUD_TOKEN"
  plaintext_value = var.atlas_cloud_token
}
