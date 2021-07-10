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

# Configure Cloud Run Service geocore-spatio. Assumes container image is already deployed
# terraform import google_cloud_run_service.geocore-spatio <region>/geocore-spatio
resource "google_cloud_run_service" "geocore-spatio" {
  name     = "geocore-spatio"
  location = var.region

  template {
    spec {
      container_concurrency = 20
      timeout_seconds = 60

      service_account_name  = "${google_service_account.geocore.email}"

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
      container_concurrency = 20
      timeout_seconds = 60

      service_account_name  = "${google_service_account.geocore.email}"

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
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].metadata
    ]
  }
}

# Configure Cloud Run Service geocore-topo. Assumes container image is already deployed
# terraform import google_cloud_run_service.geocore-topo <region>/geocore-topo
resource "google_cloud_run_service" "geocore-topo" {
  name     = "geocore-topo"
  location = var.region

  template {
    spec {
      container_concurrency = 20
      timeout_seconds = 60

      service_account_name  = "${google_service_account.geocore.email}"

      containers {
        args = []
        command = []
        image = format("%s-docker.pkg.dev/%s/geocore/geocore-topo:%s", var.region, var.project, var.geocore_version)

        env {
          name = "GCP_PROJECT"
          value = var.project
        }

        env {
          name = "GCP_REGION"
          value = var.region
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

# Configure Cloud Run Service geocore-spectral. Assumes container image is already deployed
# terraform import google_cloud_run_service.geocore-spectral <region>/geocore-spectral
resource "google_cloud_run_service" "geocore-spectral" {
  name     = "geocore-spectral"
  location = var.region

  template {
    spec {
      container_concurrency = 20
      timeout_seconds = 60

      service_account_name  = "${google_service_account.geocore.email}"

      containers {
        args = []
        command = []
        image = format("%s-docker.pkg.dev/%s/geocore/geocore-spectral:%s", var.region, var.project, var.geocore_version)

        env {
          name = "GCP_PROJECT"
          value = var.project
        }

        env {
          name = "GCP_REGION"
          value = var.region
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

# Configure Cloud Run Service geocore-analytics. Assumes container image is already deployed
# terraform import google_cloud_run_service.geocore-analytics <region>/geocore-analytics
resource "google_cloud_run_service" "geocore-analytics" {
  name     = "geocore-analytics"
  location = var.region

  template {
    spec {
      container_concurrency = 20
      timeout_seconds = 60

      service_account_name  = "${google_service_account.geocore.email}"

      containers {
        args = []
        command = []
        image = format("%s-docker.pkg.dev/%s/geocore/geocore-analytics:%s", var.region, var.project, var.geocore_version)

        env {
          name = "GCP_PROJECT"
          value = var.project
        }

        env {
          name = "GCP_REGION"
          value = var.region
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
