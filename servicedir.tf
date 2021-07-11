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

# Create Service Directory Service for GeoCore-Topo
# terraform import google_service_directory_service.geocore-topo <regionID>/geocore/geocore-topo
resource "google_service_directory_service" "geocore-topo" {
  provider   = google-beta

  service_id = "geocore-topo"
  namespace  = google_service_directory_namespace.geocore.id

  metadata = {
    url = "${google_cloud_run_service.geocore-topo.status[0].url}"
  }
}

# Create Service Directory Service for GeoCore-Spectral
# terraform import google_service_directory_service.geocore-spectral <regionID>/geocore/geocore-spectral
resource "google_service_directory_service" "geocore-spectral" {
  provider   = google-beta

  service_id = "geocore-spectral"
  namespace  = google_service_directory_namespace.geocore.id

  metadata = {
    url = "${google_cloud_run_service.geocore-spectral.status[0].url}"
  }
}

# Create Service Directory Service for GeoCore-Analytics
# terraform import google_service_directory_service.geocore-analytics <regionID>/geocore/geocore-analytics
resource "google_service_directory_service" "geocore-analytics" {
  provider   = google-beta

  service_id = "geocore-analytics"
  namespace  = google_service_directory_namespace.geocore.id

  metadata = {
    url = "${google_cloud_run_service.geocore-analytics.status[0].url}"
  }
}
