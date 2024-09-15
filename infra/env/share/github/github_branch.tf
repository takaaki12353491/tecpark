resource "github_branch" "main" {
  repository = github_repository.main.name
  branch     = "main"
}
