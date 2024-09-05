locals {
  github_paths = [
    for repo in var.github_repositories : "repo:${var.github_organization}/${repo}:*"
  ]
}
