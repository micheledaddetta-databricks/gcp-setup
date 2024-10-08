provider "google" {
  project     = var.google_project
  region      = var.region
}

provider "databricks" {
  alias         = "accounts"
  host          = "https://accounts.cloud.databricks.com"
  account_id    = var.databricks_account_id
}