# Enable Cloud Run API
resource "google_project_service" "cloudrun-api" {
  service = "run.googleapis.com"
  disable_on_destroy = false
}
