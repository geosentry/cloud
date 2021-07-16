# Enable Service Directory API
resource "google_project_service" "servicedirectory-api" {
  service = "servicedirectory.googleapis.com"
  disable_on_destroy = false
}

# Create Service Directory Namespace for GeoCore
# terraform import google_service_directory_namespace.geocore <regionID>/geocore 
resource "google_service_directory_namespace" "geocore" {
  provider     = google-beta

  location = var.region
  namespace_id = "geocore"
}

# Create Service Directory Service for GeoCore-Spatio
# terraform import google_service_directory_service.geocore-spatio <regionID>/geocore/geocore-spatio
resource "google_service_directory_service" "geocore-spatio" {
  provider   = google-beta

  service_id = "geocore-spatio"
  namespace  = google_service_directory_namespace.geocore.id

  metadata = {
    url = "${google_cloud_run_service.geocore-spatio.status[0].url}"
  }
}

# Create Service Directory Service for GeoCore-Chrono
# terraform import google_service_directory_service.geocore-spatio <regionID>/geocore/geocore-chrono
resource "google_service_directory_service" "geocore-chrono" {
  provider   = google-beta

  service_id = "geocore-chrono"
  namespace  = google_service_directory_namespace.geocore.id

  metadata = {
    url = "${google_cloud_run_service.geocore-chrono.status[0].url}"
  }
}

# Create Service Directory Service for GeoCore-Raster
# terraform import google_service_directory_service.geocore-raster <regionID>/geocore/geocore-raster
resource "google_service_directory_service" "geocore-raster" {
  provider   = google-beta

  service_id = "geocore-raster"
  namespace  = google_service_directory_namespace.geocore.id

  metadata = {
    url = "${google_cloud_run_service.geocore-raster.status[0].url}"
  }
}