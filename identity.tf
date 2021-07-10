# Enable Identity and Access Management API
resource "google_project_service" "iam-api" {
  service = "iam.googleapis.com"
  disable_on_destroy = false
}

# Create Service Account for Asset Handlers
# terraform import google_service_account.assethandler projects/<project>/serviceAccounts/assethandler@<project>.iam.gserviceaccount.com
resource "google_service_account" "assethandler" {
  account_id   = "assethandler"
  display_name = "assethandler"
  description = "Asset Handler Service Account"
}

# Create Service Account for Document Handlers
# terraform import google_service_account.documenthandler projects/<project>/serviceAccounts/documenthandler@<project>.iam.gserviceaccount.com
resource "google_service_account" "documenthandler" {
  account_id   = "documenthandler"
  display_name = "documenthandler"
  description = "Document Handler Service Account"
}

# Create Service Account for Invocation Handlers
# terraform import google_service_account.invokehandler projects/<project>/serviceAccounts/invokehandler@<project>.iam.gserviceaccount.com
resource "google_service_account" "invokehandler" {
  account_id   = "invokehandler"
  display_name = "invokehandler"
  description = "Invocation Handler Service Account"
}

# Create Service Account for GeoCore Services
# terraform import google_service_account.geocore projects/<project>/serviceAccounts/geocore@<project>.iam.gserviceaccount.com
resource "google_service_account" "geocore" {
  account_id   = "geocore"
  display_name = "geocore"
  description = "GeoCore Service Account"
}

# Create Service Account for Earth Engine
# terraform import google_service_account.earthengineone projects/<project>/serviceAccounts/earthengineone@<project>.iam.gserviceaccount.com
resource "google_service_account" "earthengineone" {
  account_id   = "earthengineone"
  display_name = "earthengineone"
  description = "Earth Engine Service Account"
}

# Create an IAM Project Binding for the datastore.user role
resource "google_project_iam_binding" "datastore-user" {
  project = var.project
  role    = "roles/datastore.user"

  members = [
    "serviceAccount:${google_service_account.documenthandler.email}",
    "serviceAccount:${google_service_account.assethandler.email}",
    "serviceAccount:${google_service_account.invokehandler.email}",
    "serviceAccount:${google_service_account.geocore.email}",
  ]
}

# Create an IAM Project Binding for the pubsub.publisher role
resource "google_project_iam_binding" "pubsub-publisher" {
  project = var.project
  role    = "roles/pubsub.publisher"

  members = [
    "serviceAccount:${google_service_account.documenthandler.email}",
    "serviceAccount:${google_service_account.invokehandler.email}",
  ]
}

# Create an IAM Project Binding for the storage.objectAdmin role
resource "google_project_iam_binding" "storage-objectadmin" {
  project = var.project
  role    = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.assethandler.email}",
    "serviceAccount:${google_service_account.earthengineone.email}",
  ]
}

# Create an IAM Project Binding for the secretmanager.secretAccessor role
resource "google_project_iam_binding" "secretmanager-accessor" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"

  members = [
    "serviceAccount:${google_service_account.geocore.email}",
  ]
}

# Create an IAM Project Binding for the run.invoker role
resource "google_project_iam_binding" "run-invoker" {
  project = var.project
  role    = "roles/run.invoker"

  members = [
    "serviceAccount:${google_service_account.invokehandler.email}",
  ]
}

# Create an IAM Project Binding for the servicedirectory.viewer role
resource "google_project_iam_binding" "servicedirectory-viewer" {
  project = var.project
  role    = "roles/servicedirectory.viewer"

  members = [
    "serviceAccount:${google_service_account.invokehandler.email}",
  ]
}
