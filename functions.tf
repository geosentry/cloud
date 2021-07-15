# Enable Cloud Functions API
resource "google_project_service" "cloudfunctions-api" {
  service = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

# Configure Cloud Function asset-create. Assumes function code is already deployed
# terraform import google_cloudfunctions_function.asset-create asset-create
resource "google_cloudfunctions_function" "asset-create" {
    name = "asset-create"
    # description = "A function handles new asset object creations from a GCS bucket"

    runtime = "python39"
    entry_point = "main"
    available_memory_mb = 512

    service_account_email = "${google_service_account.assethandler.email}"

    event_trigger {
        event_type = "google.storage.object.finalize"
        resource = "geosentry-assets"
        failure_policy {
            retry = false
        }  
    }

    labels = {
        deployment-tool = "cli-gcloud"
    }
}

# Configure Cloud Function region-create. Assumes function code is already deployed
# terraform import google_cloudfunctions_function.region-create region-create
resource "google_cloudfunctions_function" "region-create" {
    name = "region-create"
    # description = "A function handles new region document creations from Firestore"

    runtime = "go113"
    entry_point = "Main"
    available_memory_mb = 256

    service_account_email = "${google_service_account.invokehandler.email}"

    event_trigger {
        event_type = "providers/cloud.firestore/eventTypes/document.create"
        resource = format("projects/%s/databases/(default)/documents/regions/{region}", var.project)
        failure_policy {
            retry = false
        }  
    }

    environment_variables = {
        GCP_PROJECT = var.project
        GCP_REGION = var.region
    }

    labels = {
        deployment-tool = "cli-gcloud"
    }
}
