# Enable Secret Manager API
resource "google_project_service" "secretmanager-api" {
  service = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

# Create an Earth Engine Secret
# terraform import google_secret_manager_secret.earthengineone earthengineone 
resource "google_secret_manager_secret" "earthengineone" {
  secret_id = "earthengineone"

  labels = {
    service = "earthengine"
  }

  replication {
    automatic = true
  }
}
