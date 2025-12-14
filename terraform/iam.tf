# Service account for Cloud Run
resource "google_service_account" "cloudrun_sa" {
  account_id   = "insight-agent-sa"
  display_name = "Insight Agent Cloud Run Service Account"
  project      = var.project_id
}


# Minimal IAM roles assigned to the Cloud Run service account
resource "google_project_iam_member" "sa_artifact_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}


# Additional roles that may be required by the service to read secrets / logging
resource "google_project_iam_member" "sa_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}