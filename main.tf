# Setup Terraform Providers
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
  }
}

# Setup Variable for Project ID
variable "project" {
  type        = string
  description = "Google Cloud Platform Project ID"
}

# Setup Variable for Region
variable "region" {
  type    = string
  default = "asia-south1"
  description = "Google Cloud Platform Deployment Region"
}

# Setup GCP Provider
provider "google" {
  region = var.region
  project = var.project
}

# Setup GCP Project
# terraform import google_project.geosentry-project <projectID>
resource "google_project" "geosentry-project" {
  name       = "GeoSentry"
  project_id = var.project
}