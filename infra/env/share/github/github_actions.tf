resource "github_actions_secret" "atlas_cloud_token" {
  repository      = var.github_repository
  secret_name     = "ATLAS_CLOUD_TOKEN"
  plaintext_value = var.atlas_cloud_token
}
