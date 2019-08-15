provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
  credentials = file(var.gcp_credentials)
}

resource "google_cloudfunctions_function" "function" {
  name        = "gcp-billing-report-function"
  runtime     = "go111"
  entry_point = "F"

  event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource   = google_pubsub_topic.trigger.name
  }

  source_repository {
    url = "https://source.developers.google.com/projects/${var.gcp_project}/repos/${var.gcp_repository}/moveable-aliases/${var.github_branch}/paths/function"
  }

  environment_variables = {
    SLACK_TOKEN      = var.slack_token
    SLACK_CHANNEL_ID = var.slack_channel_id
  }
}

data "google_billing_account" "billing" {
  display_name = "billing-account-1"
  open         = true
}

resource "google_logging_billing_account_sink" "sink" {
  name            = "gcp-billing-report-function-billing-sink"
  billing_account = data.google_billing_account.billing.id
  destination     = google_pubsub_topic.trigger.id
}

resource "google_pubsub_topic" "trigger" {
  name = "gcp-billing-report-function-trigger"
}
