variable "project_id" {
  description = "GCP project ID"
  type        = string
}


variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}


variable "location" {
  description = "Artifact Registry location (same as region)"
  type        = string
  default     = "us-central1"
}


variable "credentials_file" {
  description = "Path to the service account key JSON file for Terraform (local path)"
  type        = string
  default     = "./terraform-sa.json"
}


variable "artifact_repo" {
  description = "Artifact Registry repository name"
  type        = string
  default     = "insight-agent-repo"
}


variable "cloud_run_service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "insight-agent"
}


variable "image_url" {
  description = "Full image URL pushed to Artifact Registry. e.g. LOCATION-docker.pkg.dev/PROJECT/REPO/IMAGE:TAG"
  type        = string
  default     = ""
}