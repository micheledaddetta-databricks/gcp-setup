provider "google" {
  project     = var.google_project
  region      = var.region
}

provider "databricks" {
  alias         = "accounts"
  host          = "https://accounts.gcp.databricks.com"
  account_id    = "e11e38c5-a449-47b9-b37f-0fa36c821612"
}