# Enable Cloud Run API
resource "google_project_service" "cloudrun-api" {
  service = "run.googleapis.com"
  disable_on_destroy = false
}

# Setup Variable for GeoCore Version
variable "geocore_version" {
  type        = string
  description = "GeoCore Version Tag"
}

# Setup Variable for GCP Project ID
variable "maps_apikey" {
  type        = string
  description = "Google Maps Platform API Key"
  sensitive = true
}

# Configure Cloud Run Service geocore-spatio. Assumes container image is already deployed
# terraform import google_cloud_run_service.geocore-spatio <region>/geocore-spatio
resource "google_cloud_run_service" "geocore-spatio" {
  name     = "geocore-spatio"
  location = var.region

  template {
    spec {
      container_concurrency = 5
      timeout_seconds = 60

      service_account_name  = "${google_service_account.geocore-spatio.email}"

      containers {
        args = []
        command = []
        image = format("%s-docker.pkg.dev/%s/geocore/geocore-spatio:%s", var.region, var.project, var.geocore_version)

        env {
          name = "GCP_PROJECT"
          value = var.project
        }

        env {
          name = "GCP_REGION"
          value = var.region
        }

        env {
          name = "MAPS_APIKEY"
          value = var.maps_apikey
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].metadata
    ]
  }
}

# Configure Cloud Run Service geocore-chrono. Assumes container image is already deployed
# terraform import google_cloud_run_service.geocore-chrono <region>/geocore-chrono
resource "google_cloud_run_service" "geocore-chrono" {
  name     = "geocore-chrono"
  location = var.region

  template {
    spec {
      container_concurrency = 5
      timeout_seconds = 60

      service_account_name  = "${google_service_account.geocore-chrono.email}"

      containers {
        args = []
        command = []
        image = format("%s-docker.pkg.dev/%s/geocore/geocore-chrono:%s", var.region, var.project, var.geocore_version)

        env {
          name = "GCP_PROJECT"
          value = var.project
        }

        env {
          name = "GCP_REGION"
          value = var.region
        }

        env {
          name = "MAPS_APIKEY"
          value = var.maps_apikey
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].metadata
    ]
  }
}

# Configure Cloud Run Service geocore-raster. Assumes container image is already deployed
# terraform import google_cloud_run_service.geocore-raster <region>/geocore-raster
resource "google_cloud_run_service" "geocore-raster" {
  name     = "geocore-raster"
  location = var.region

  template {
    spec {
      container_concurrency = 5
      timeout_seconds = 60

      service_account_name  = "${google_service_account.geocore-raster.email}"

      containers {
        args = []
        command = []
        image = format("%s-docker.pkg.dev/%s/geocore/geocore-raster:%s", var.region, var.project, var.geocore_version)

        env {
          name = "GCP_PROJECT"
          value = var.project
        }

        env {
          name = "GCP_REGION"
          value = var.region
        }

        env {
          name = "MAPS_APIKEY"
          value = var.maps_apikey
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].metadata
    ]
  }
}