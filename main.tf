# Setup Terraform Providers
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.74"
    }
  }
}

# Setup Variable for GCP Project ID
variable "project" {
  type        = string
  description = "Google Cloud Platform Project ID"
}

# Setup Variable for GCP Deployment Region
variable "region" {
  type    = string
  default = "asia-south1"
  description = "Google Cloud Platform Deployment Region"
}

# Setup Provider for google
provider "google" {
  region = var.region
  project = var.project
}

# Setup Provider for google-beta
provider "google-beta" {
  region = var.region
  project = var.project
}

# Setup GCP Project
# terraform import google_project.geosentry-project <projectID>
resource "google_project" "geosentry-project" {
  name       = "GeoSentry"
  project_id = var.project
}

# Enable Google Earth Engine API
resource "google_project_service" "earthengine-api" {
  service = "earthengine.googleapis.com"
  disable_on_destroy = false
}

# Enable Cloud Build API
resource "google_project_service" "cloudbuild-api" {
  service = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}
