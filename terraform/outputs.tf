output "cloud_run_url" {
  description = "Cloud Run URL (may require authentication to access)"
  value       = google_cloud_run_service.service.status[0].url
}