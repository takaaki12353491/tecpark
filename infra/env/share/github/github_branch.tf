resource "github_branch" "main" {
  repository = github_repository.main.name
  branch     = "main"
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = github_branch.main.branch
}

resource "github_branch_protection" "main" {
  repository_id = github_repository.main.node_id
  pattern       = github_branch.main.branch

  allows_deletions                = false
  allows_force_pushes             = false
  enforce_admins                  = true
  require_conversation_resolution = true
  required_linear_history         = true
}
