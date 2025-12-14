# Enable APIs
resource "google_project_service" "artifactregistry" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}
resource "google_project_service" "cloudrun" {
  project = var.project_id
  service = "run.googleapis.com"
}
resource "google_project_service" "cloudbuild" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}
resource "google_project_service" "iam" {
  project = var.project_id
  service = "iam.googleapis.com"
}


# Artifact Registry repository
resource "google_artifact_registry_repository" "repo" {
  provider      = google
  project       = var.project_id
  location      = var.location
  repository_id = var.artifact_repo
  format        = "DOCKER"
  description   = "Artifact Registry for Insight-Agent images"
}