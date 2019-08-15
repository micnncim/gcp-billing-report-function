variable "gcp_project" {
  type = "string"
}

variable "gcp_region" {
  type    = "string"
  default = "asia-northeast1"
}

variable "gcp_zone" {
  type    = "string"
  default = "asia-northeast1-a"
}

variable "gcp_credentials" {
  type    = "string"
  default = "../secrets/credentials.json"
}

variable "gcp_repository" {
  type = "string"
}

variable "github_branch" {
  type    = "string"
  default = "master"
}

variable "slack_token" {
  type = "string"
}

variable "slack_channel_id" {
  type = "string"
}
