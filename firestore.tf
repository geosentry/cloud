# Enable Firestore API
resource "google_project_service" "firestore-api" {
  service = "firestore.googleapis.com"
  disable_on_destroy = false
}

# Create App Engine Instance and Firestore Database
# terraform import google_app_engine_application.app <projectID>
resource "google_app_engine_application" "app" {
  project     = var.project
  location_id = var.region

  database_type = "CLOUD_FIRESTORE"
}

# TODO: Create Firestore Index and Collection Groups
