# Enable Arifact Registry API
resource "google_project_service" "artifactregistry-api" {
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

# Create Docker Repository for GeoCore
# terraform import google_artifact_registry_repository.geocore <projectID>/asia-south1/geocore
resource "google_artifact_registry_repository" "geocore" {
  provider = google-beta

  location = var.region
  project = var.project

  repository_id = "geocore"
  description = "geocore container repository"
  format = "DOCKER"
}
