# Cloud Run service
resource "google_cloud_run_service" "service" {
  name     = var.cloud_run_service_name
  project  = var.project_id
  location = var.region


  template {
    spec {
      service_account_name = google_service_account.cloudrun_sa.email
      containers {
        image = var.image_url
        ports {
          container_port = 8080
        }
      }
    }
  }


  # Make the service **not** publicly accessible by default
  traffics {
    percent         = 100
    latest_revision = true
  }


  # Prevent unauthenticated invocations (no allUsers member)
  autogenerate_revision_name = true
}


# Remove public (allUsers) invoker if present
resource "google_cloud_run_service_iam_member" "no_public" {
  project  = var.project_id
  location = var.region
  service  = google_cloud_run_service.service.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}