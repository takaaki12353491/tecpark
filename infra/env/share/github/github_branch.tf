resource "github_branch" "main" {
  repository = github_repository.main.name
  branch     = "main"
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = github_branch.main.branch
}
