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

# Create Service Account for the GeoCore Spatio service
# terraform import google_service_account.geocore-spatio projects/<project>/serviceAccounts/geocore-spatio@<project>.iam.gserviceaccount.com
resource "google_service_account" "geocore-spatio" {
  account_id   = "geocore-spatio"
  display_name = "geocore-spatio"
  description = "GeoCore Spatio Service Account"
}

# Create Service Account for GeoCore Chrono service
# terraform import google_service_account.geocore-chrono projects/<project>/serviceAccounts/geocore-chrono@<project>.iam.gserviceaccount.com
resource "google_service_account" "geocore-chrono" {
  account_id   = "geocore-chrono"
  display_name = "geocore-chrono"
  description = "GeoCore Chrono Service Account"
}

# Create Service Account for GeoCore Raster service
# terraform import google_service_account.geocore-raster projects/<project>/serviceAccounts/geocore-raster@<project>.iam.gserviceaccount.com
resource "google_service_account" "geocore-raster" {
  account_id   = "geocore-raster"
  display_name = "geocore-raster"
  description = "GeoCore Raster Service Account"
}

# Create Service Account for GeoCore Vector service
# terraform import google_service_account.geocore-vector projects/<project>/serviceAccounts/geocore-vector@<project>.iam.gserviceaccount.com
resource "google_service_account" "geocore-vector" {
  account_id   = "geocore-vector"
  display_name = "geocore-vector"
  description = "GeoCore Vector Service Account"
}

# Create an IAM Project Binding for the datastore.user role
resource "google_project_iam_binding" "datastore-user" {
  project = var.project
  role    = "roles/datastore.user"

  members = [
    "serviceAccount:${google_service_account.documenthandler.email}",
    "serviceAccount:${google_service_account.assethandler.email}",
    "serviceAccount:${google_service_account.invokehandler.email}",
    "serviceAccount:${google_service_account.geocore-vector.email}",
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
    "serviceAccount:${google_service_account.geocore-raster.email}",
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

# Create an IAM Project Binding for the cloudtasks.enqueuer role
resource "google_project_iam_binding" "cloudtasks-enqueuer" {
  project = var.project
  role    = "roles/cloudtasks.enqueuer"

  members = [
    "serviceAccount:${google_service_account.invokehandler.email}",
  ]
}

# Create an IAM Project Binding for the earthengine.admin role
resource "google_project_iam_binding" "earthengine-admin" {
  project = var.project
  role    = "roles/earthengine.admin"

  members = [
    "serviceAccount:${google_service_account.geocore-vector.email}",
    "serviceAccount:${google_service_account.geocore-raster.email}",
  ]
}

# Create an IAM Project Binding for the serviceusage.serviceUsageConsumer role
resource "google_project_iam_binding" "serviceusage-consumer" {
  project = var.project
  role    = "roles/serviceusage.serviceUsageConsumer"

  members = [
    "serviceAccount:${google_service_account.geocore-vector.email}",
    "serviceAccount:${google_service_account.geocore-raster.email}",
    "serviceAccount:${google_service_account.geocore-chrono.email}",
  ]
}