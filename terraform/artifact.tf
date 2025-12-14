# terraform/artifacts.tf
resource "google_artifact_registry_repository" "insight_agent_repo" {
  provider      = google
  location      = var.location
  repository_id = var.artifact_repo
  format        = "DOCKER"
  description   = "Artifact Registry repository for Insight-Agent Docker images"
}

